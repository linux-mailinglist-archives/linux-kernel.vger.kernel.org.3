Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A8501882
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiDNQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347432AbiDNQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52719FA20A;
        Thu, 14 Apr 2022 08:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10C8BB82A61;
        Thu, 14 Apr 2022 15:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98755C385A1;
        Thu, 14 Apr 2022 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649951607;
        bh=vXueds4VuC74iLCMybsPZmL3wsTpJ6AYZXEWJtsFltc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVlrHrq9iS0fvnwKbYeUOEnnL9wxjnCbN3bSgvsuN9aJYKMx77j/5W27OQZ9xYl/e
         g7yIjWea4TGP9Rs9l7bSoBH3mf0TcuEQeqTbKbbNZUnGAkGDoKKWuqE0jxNP8hJcRi
         u3viLk71BcM/9sstR79aHyKX8ng6N77guDgz/wLrVN+bY2+YzZdcsezJ+gatRX72r0
         kU6le2F7BlDoRbjf6580EeI8KyuaDXGJJn252kb62h5id5pzPy09f+ZIaxrhn5doAe
         zqcDtY6rEycMwDCi3UXSn7Dl9ApANob09OGNu4YZpqrC3dd6Brgft1X4QgNNw/pVAo
         6tvGAgnqoFg8A==
Date:   Thu, 14 Apr 2022 21:23:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Md Sadre Alam <quic_mdalam@quicinc.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, quic_srichara@quicinc.com
Subject: Re: [PATCH V2] mtd: rawnand: qcom: fix memory corruption that causes
 panic
Message-ID: <20220414155319.GB20493@thinkpad>
References: <1649950217-32272-1-git-send-email-quic_mdalam@quicinc.com>
 <20220414173642.56baedf5@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173642.56baedf5@xps13>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:36:42PM +0200, Miquel Raynal wrote:
> Hi Md,
> 
> quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 21:00:17 +0530:
> 
> > This patch fixes a memory corruption that occurred in the
> > nand_scan() path for Hynix nand device.
> > 
> > On boot, for Hynix nand device will panic at a weird place:
> > | Unable to handle kernel NULL pointer dereference at virtual
> >   address 00000070
> > | [00000070] *pgd=00000000
> > | Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> > | Modules linked in:
> > | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-01473-g13ae1769cfb0
> >   #38
> > | Hardware name: Generic DT based system
> > | PC is at nandc_set_reg+0x8/0x1c
> > | LR is at qcom_nandc_command+0x20c/0x5d0
> > | pc : [<c088b74c>]    lr : [<c088d9c8>]    psr: 00000113
> > | sp : c14adc50  ip : c14ee208  fp : c0cc970c
> > | r10: 000000a3  r9 : 00000000  r8 : 00000040
> > | r7 : c16f6a00  r6 : 00000090  r5 : 00000004  r4 :c14ee040
> > | r3 : 00000000  r2 : 0000000b  r1 : 00000000  r0 :c14ee040
> > | Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
> > | Control: 10c5387d  Table: 8020406a  DAC: 00000051
> > | Register r0 information: slab kmalloc-2k start c14ee000 pointer offset
> >   64 size 2048
> > | Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> > | nandc_set_reg from qcom_nandc_command+0x20c/0x5d0
> > | qcom_nandc_command from nand_readid_op+0x198/0x1e8
> > | nand_readid_op from hynix_nand_has_valid_jedecid+0x30/0x78
> > | hynix_nand_has_valid_jedecid from hynix_nand_init+0xb8/0x454
> > | hynix_nand_init from nand_scan_with_ids+0xa30/0x14a8
> > | nand_scan_with_ids from qcom_nandc_probe+0x648/0x7b0
> > | qcom_nandc_probe from platform_probe+0x58/0xac
> > 
> > The problem is that the nand_scan()'s qcom_nand_attach_chip callback
> > is updating the nandc->max_cwperpage from 1 to 4.This causes the
> > sg_init_table of clear_bam_transaction() in the driver's
> > qcom_nandc_command() to memset much more than what was initially
> > allocated by alloc_bam_transaction().
> > 
> > This patch will update nandc->max_cwperpage 1 to 4 after nand_scan()
> > returns, and remove updating nandc->max_cwperpage from
> > qcom_nand_attach_chip call back.
> 
> Please update also the commit log.
> 
> Fixes: ?
> Cc: stable ?

Also please add Reported-by to credit Konrad.

Thanks,
Mani

> 
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> > ---
> > [V2]
> 
> Thanks,
> Miquèl

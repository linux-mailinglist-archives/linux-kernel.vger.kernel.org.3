Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313D64F96B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiDHNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiDHNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:31:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C233ADD60;
        Fri,  8 Apr 2022 06:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D26B829D8;
        Fri,  8 Apr 2022 13:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C3C385A1;
        Fri,  8 Apr 2022 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649424592;
        bh=ZYBCD+SPuaGoxrvq8XHNiTRw9xSpDQGJOvCPXfOLPQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1lQ5PFIN1NRAsqYA4S6/bjVaNjL4bLs1G19GAvsgRWJL8/UjLVc7xD/rpTa2ysZC
         DyEhFeJYZshOf/8vVNnZN15nT7yWHYTgUAwbdWyAqbRzREeO3FGea9v0A/FwzJWJXk
         Fxbyz/Uoal++MJCQx04x+damhnPtRzgHUpQUi7dmbutgq+ZzFrol6Df5WE08Fyf3ZZ
         t3ceR3WHO6Ugksnyt5nMaiCiglr2fvREbh8dXI6EARox6Dx0aQdxQEQQqdft0XAG46
         0Up7E87EknJBEpyjXc+gOGxU91HuyJiF9Hdmpotj/fZ60rU34/eXAPdRERvMvfc5/g
         rGapS3feISiCQ==
Date:   Fri, 8 Apr 2022 18:59:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Sricharan Ramabadhran <sricharan@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        pragalla@codeaurora.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org,
        bbhatt@codeaurora.org, hemantk@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220408132941.GA12635@thinkpad>
References: <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
 <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
 <12cad24a-fa2f-9a82-cf43-241a0a6fe4f6@somainline.org>
 <20220201145204.54646475@xps13>
 <d79bf21d-5a90-0074-cef6-896f66e80d28@somainline.org>
 <c63d5410-7f08-80fe-28ac-f4867038ff30@codeaurora.org>
 <cc1302f4-9150-0145-421c-bf2b7a7bf258@codeaurora.org>
 <6b839237-74f0-7270-2f33-f5c17e6b59de@somainline.org>
 <2fb9d943-d6c8-06b1-08cc-b0c3a8256082@codeaurora.org>
 <b428593e-a4db-984b-df7f-7cd14795d5e2@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b428593e-a4db-984b-df7f-7cd14795d5e2@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 11, 2022 at 10:22:51PM +0100, Konrad Dybcio wrote:
> 
>

[...]
 
> I have 3 logs for you:
> 
> [1] is KASAN=y, with this patch
> [2] is KASAN=y, WITHOUT this patch (should die, but doesn't - does KASAN prevent it from doing something stupid?)
> [3] is KASAN=n, WITHOUT this patch (dies as expected)
> 

We reproduced the same issue on SDX65-MTP board and your hack worked :)
Since this board is available inside Qcom, now Sadre and Sricharan should be
able to investigate it properly.

Thanks,
Mani

> Looks like there's a lot happening..
> 
> 
> Konrad
> > 
> > Regards,
> >   Sricharan
> > 
> > 
> 
> [1] https://paste.debian.net/1233873/
> [2] https://paste.debian.net/1233874/
> [3] https://paste.debian.net/1233878/

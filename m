Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F85597F94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbiHRHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiHRHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:55:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B1642C8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:55:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bu15so769590wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Oc8VuY9dui/DMr9ExY40tj69aQlYh+Z/nKcO2XmJf6g=;
        b=msuEfj+N88tQ11omyQz+r1D+Zis2Zkqgu0u1DK+0Rz+rNp/pKFT9ERD5E1O9+nmlpV
         VH4pszzqEvYNVrLfDvnVc7WK1pb+ve8hg5BodLzCiG6IDybV7ThUkKaVYbHGVQLN0pZS
         4VIUKEeFEGWgexwvjZ9rAiKuyVKe2U4c4EAETUxd8iq/D0tSPK0kx7aktD34MtvcTLf1
         xDEqsFzF8VGb20pysPsD0rU5QSTG1/pBavGK1f4XBUYQoYqENmm/wnMxdVU5Bzv+yW0Q
         TvMMQtKYfUv4HdKKhNP193rKABe9wlrvsrbdTmhN7xomk79xu3Y6FiVaDea3TdfEjEV5
         SNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Oc8VuY9dui/DMr9ExY40tj69aQlYh+Z/nKcO2XmJf6g=;
        b=8LMJMulmGTxgMu0t+EJCLZlUxEYuzA1DNBzba6SDfUPip8NmUTfUGEHqvHKnjgf+p/
         ZDkKtQBPUHPnkHPnkcffVzHYyzBQByGqKUFQks/yWi2D/CkYBECvwCLaaoVP/rKBOdWo
         TVB+Rxl/Mbc0Kcpn7QKNjejeM4OBptSvLhmwwMlHkytxtygygbmJ+h6gxTtV8hu5/dLw
         4P6czsfVCz43FeeovkG0WcS93DV1Ufu3+azgl72z9P9e8Igamo87WQRN684FvT8hHblB
         6REuEAXJyPkby2LDRxTBQTOhJsrZJnKuLzbfUi9U+Ii9zLs2vvXbAGcKJ5gyW9zkeUy1
         XdTA==
X-Gm-Message-State: ACgBeo3A+AsSkfUk8LUfuWHs/CuL1CKZ4MdzGfiERLGIdpYIgAd5LFUp
        +ecjgRJetTYrnOEMALNazKhFsA==
X-Google-Smtp-Source: AA6agR5L2j3x26RVRuhmovvaS87B9ci/rPFMOuxpJsGPEnmZdMiTE1zh0J/uT5NLnS+2zpGoXx3w/Q==
X-Received: by 2002:adf:e401:0:b0:225:2124:183d with SMTP id g1-20020adfe401000000b002252124183dmr836432wrm.146.1660809319446;
        Thu, 18 Aug 2022 00:55:19 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe38e000000b002251e86241csm655615wrm.48.2022.08.18.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:55:19 -0700 (PDT)
Date:   Thu, 18 Aug 2022 08:55:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     RAJESH DASARI <raajeshdasari@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, df@google.com
Subject: Re: bpf selftest failed in 5.4.210 kernel
Message-ID: <Yv3wZLuPEL9B/h83@myrica>
References: <CAPXMrf-C5XEUfOJd3GCtgtHOkc8DxDGbLxE5=GFmr+Py0zKxJA@mail.gmail.com>
 <Yv3M8wqMkLwlaHxa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv3M8wqMkLwlaHxa@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 07:24:03AM +0200, Greg KH wrote:
> On Wed, Aug 17, 2022 at 09:22:00PM +0300, RAJESH DASARI wrote:
> > Hi ,
> > 
> > We are running bpf selftests on 5.4.210 kernel version and we see that
> > test case 11 of  test_align failed. Please find the below error.
> > 
> > selftests: bpf: test_align
> > Test  11: pointer variable subtraction ... Failed to find match 16:
> > R5_w=pkt(id=2,off=0,r=0,umin_value=2,umax_value=1082,var_off=(0x2;
> > 0xfffffffc)
> > # func#0 @0
> > # 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
> > # 0: (61) r2 = *(u32 *)(r1 +76)
> > # 1: R1=ctx(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> > # 1: (61) r3 = *(u32 *)(r1 +80)
> > 
> > For complete errors please see the attached file. The same test case
> > execution was successful in the 5.4.209 version , could you please let
> > me know any known issue with the recent changes in 5.4.210 and how to
> > fix these errors.
> 
> Can you use 'git bisect' to find the offending commit?

It probably is 6098562ed9df ("selftests/bpf: Fix "dubious pointer
arithmetic" test")
https://lore.kernel.org/all/20220803145005.2385039-6-ovidiu.panait@windriver.com/
Could you try reverting that?

The patch didn't have a Fixes: tags, because the bugfix it refers to was
merged at the same time. That bugfix is upstream commit b02709587ea3
("bpf: Fix propagation of 32-bit signed bounds from 64-bit bounds.")

Since b02709587ea3 was only backported down to 5.10, this fix shouldn't be
in 5.4. Sorry for not catching this earlier.

Thanks,
Jean



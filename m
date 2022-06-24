Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B355A261
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiFXUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiFXUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:13:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E731532
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:13:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r66so3385982pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JO7J5gYwMc2oJpLpkWigLEC53bU/Q4t+rjJSx2/0CdY=;
        b=eGNfcAvYM1eEBkUwfnn/Tbo9MYHzrrNAEqTo3aweTmsmcvdHJIQolhJdks3ZI06Hnz
         ToODfaBXKu5XQl3iJjSxgXgx6b2mCmS/au7xy6QtVRe0KR4YlQCAc0i1LzEkzN2B9d7a
         f9wuhNf0912A84p4kuE5f2tjgeK9s/ObIhPYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JO7J5gYwMc2oJpLpkWigLEC53bU/Q4t+rjJSx2/0CdY=;
        b=1Bt2df7BaGPbNgXSm0l5F9V97mH8RKzWvU57PKjiETF59feUOondqfWt9KMgHKzkb7
         9mpFqnJzF+x+0ZQLrcJ7aY4vVM2eWi6V3Xg1UaKburufBYrYzx8I3iQGM2HRkqyAocYI
         36vi2qwj7gPqhkWi0eVFV0QL5uOGxhMvjLeZeA3ADJz8UDFt7BqDYLBEGkMrT5OJqaO/
         yQH6s5S5jX9BV0lMcqhsdXb1ALonfbWnPIp13AwQhfVH2inlfILE7ALGxPsLSmpVmCdx
         tKNG8LBDERpkkpRiSsfaFJm6zFN4HNziPArWMBv0KMAC4ighG8gHqUMfiZ/7wEFsEM2m
         ZPsg==
X-Gm-Message-State: AJIora+nhvWN1Q54fI7X6hiozBc+FwK5wZTtRkLUtgnckEeVd7iSXubA
        RLlsDbxcMUk+CwIvxNMB6Cd9uw==
X-Google-Smtp-Source: AGRyM1skZyJeAmzbptZd5plp8ZRer/MKu/mlvmAuyKbVM9kantiVUC5Iiok1Xs7xFNvbtfSGSAKjZw==
X-Received: by 2002:a63:8c1b:0:b0:40c:7af0:cdaa with SMTP id m27-20020a638c1b000000b0040c7af0cdaamr513452pgd.326.1656101591612;
        Fri, 24 Jun 2022 13:13:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902e14a00b0016196bd15f4sm2228549pla.15.2022.06.24.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:13:11 -0700 (PDT)
Date:   Fri, 24 Jun 2022 13:13:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/4][next] scsi: megaraid_sas: Replace one-element
 array with flexible-array member in MR_DRV_RAID_MAP
Message-ID: <202206241312.EC413977@keescook>
References: <cover.1628136510.git.gustavoars@kernel.org>
 <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
 <202206221457.1A12D768EF@keescook>
 <20220623014533.GA7132@embeddedor>
 <20220623031401.GA8896@embeddedor>
 <202206230816.1383511C@keescook>
 <20220623153825.GA6458@embeddedor>
 <202206241047.903049ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206241047.903049ED@keescook>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:48:39AM -0700, Kees Cook wrote:
> On Thu, Jun 23, 2022 at 05:38:25PM +0200, Gustavo A. R. Silva wrote:
> > Which object files are you comparing here? because I don't see the zero
> > change when comparing the before and after of megaraid_sas_fp.o with
> > the change you propose.
> 
> Hm, maybe I did something wrong. But I was looking at megaraid_sas_fp.o

Explaining my process got a bit long, so I wrote a blog post on it.
Here's how I did my examination of the resulting output:

https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

-- 
Kees Cook

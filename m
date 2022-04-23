Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998850C9B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiDWLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiDWLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:49:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A42FAD22
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:46:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so16492199plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J0S0S5fuFEbU9yXYTubsjxw2YWpXKUGELZ8mwol2duc=;
        b=bq8q2kzQEI0IEZeJno5JXEsEmtsP2XDtX8a7APwWbw8Bu6I9elN+nstWWF+B3Y0s2m
         pi7xJXoGCbXsysoZ2VmqVW3jxkDWwKZDOc7rRaa4Valv2baAqWC4Qf8xeRWvnXcCu/84
         TdHKR5MScLcIgRyRos+4if64pht/FJhObjCGh4DP/0cNKgCoTDsaHm5LqylisPBGuRS0
         LZURRVR8iERZkDcb8SayTQXPA6j1JcOYw0rYgOxYGrmvTAhnZIPRbNepLh8yT2WKpfL5
         ZMJ/ChqeuIsrJDYyfRidus+ONKG+hdvNCQxSfTZxxrXmgTvnTHAtWRu1mYaoF2U9b/v/
         AYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0S0S5fuFEbU9yXYTubsjxw2YWpXKUGELZ8mwol2duc=;
        b=a+8yiMkVR4XZr71Z7xAr8mq0pl7UNGXm7JBlPtSVgp9L8reoISl1S/XDo/1maS9don
         FWeq6RBORayZdhLW4CMiXRUyz/DFt5RFHEhE0IPnH9+W/8MWtDgtPzCWnhgWInxtBJ5o
         aBcyjc1OqgmGgVIrTIDkJ6JXxVfHnXg1XU+Yzj7YUB06RcAQUTAMFPw95N89WTJw+vrx
         026FgJq8gdDCNqDk8vOsI5S/XFeoicy+d8XAroWrStWnuZFRn6trJ20xmzzKnI5CVmxR
         /J2uTkCauirP0IfLZE3PhXpXHclGGGJfy/LRQGFx4PfrkkMPc6GD3Jx330wxnpvv40XS
         8EFQ==
X-Gm-Message-State: AOAM530wHupS9CVd/PkmVuHaY/8PlyW4szGFY/z2ZbnEtPM5A9cSsseP
        SY6/j906jEwVN13JucE64/LL
X-Google-Smtp-Source: ABdhPJygyj7U3ci2JCo8JtRud845IZLWNNfXjTuuKJYcvw6sZFDL45L1g8kw+xMiMNLDVNOCZ8ysxA==
X-Received: by 2002:a17:90a:5991:b0:1d9:27f3:74cc with SMTP id l17-20020a17090a599100b001d927f374ccmr3694119pji.90.1650714403387;
        Sat, 23 Apr 2022 04:46:43 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a714600b001d7f3bb11d7sm5446077pjs.53.2022.04.23.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:46:42 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:16:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] scsi: ufs: core: Remove redundant wmb() in
 ufshcd_send_command()
Message-ID: <20220423114635.GC374560@thinkpad>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
 <20220422132140.313390-5-manivannan.sadhasivam@linaro.org>
 <10d7e4a7-4364-b579-fecf-53c953d22b7d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d7e4a7-4364-b579-fecf-53c953d22b7d@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:19:14PM -0700, Bart Van Assche wrote:
> On 4/22/22 06:21, Manivannan Sadhasivam wrote:
> > The wmb() inside ufshcd_send_command() is added to make sure that the
> > doorbell is committed immediately.
> 
> That's not the purpose of the wmb() call so I think the comment is wrong.
> 
> > This leads to couple of expectations:
> > 
> > 1. The doorbell write should complete before the function return.
> > 2. The doorbell write should not cross the function boundary.
> > 
> > 2nd expectation is fullfilled by the Linux memory model as there is a
> > guarantee that the critical section won't cross the unlock (release)
> > operation.
> 
> I think you meant that the writel() won't cross the unlock operation?
> 

yes!

Thanks,
Mani

> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 9349557b8a01..ec514a6c5393 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -2116,9 +2116,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
> >   	__set_bit(task_tag, &hba->outstanding_reqs);
> >   	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> >   	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> > -
> > -	/* Make sure that doorbell is committed immediately */
> > -	wmb();
> >   }
> 
> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

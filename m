Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20914DCB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiCQQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiCQQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:31:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87931546A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:29:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3449379wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kDi3u2Fpg/HiXJzQg2FZCCoSOv6AyU+mSPjwymI3Wrk=;
        b=Dbb/8Docx3JTOXH60FA+hbNfnEYP7UBzIjJoDwrd1r6mggFsnSY4yDS6VjLRxwLPR9
         +tA7aTZqsDMqFHX/eLD1WxC0gJEFcaN/G03bcPmpaaRn4uoYjl00++75Wg5L3b3FRaRB
         T9u5QGf1vasN5p7hCKssa3nPWpDHp4GYPfmLyhdR7dsJI0XDxAd4rrUJHkHGPupNFoOh
         ldxg3+NAUKNu51ddPY+APck86WOwjix1WglymXDjNfWciAA4mC9PDzbuo3bP5djjWuMB
         0jZGbUWW28WmzooF5W4SbygRR+sOFe7+mIuUhhE940fM4eNtxFkL3LBMxZiT64Gz1+Ym
         FF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kDi3u2Fpg/HiXJzQg2FZCCoSOv6AyU+mSPjwymI3Wrk=;
        b=6tg+x8kHpbgTabtTcZImJ/4IhFs/BuOA/RyqZSJwqjp2wpUJAqp/WqCvagsOdi9b7F
         H4WOkmKHSMe6dvQQS/KkUjNpuyw702U9wk/QCX5c9hw6t5DW6JdCrPwliQPMSVzaTCKl
         0i2GI3+//q1U1OfqgjH1B/V8Ifely4n9H1AqzpoBUEHkvOvWeeI/erjFuCm1U+4SaGpJ
         QN3OQB+Xi+C0Hr8NORBqaEOiPserJp052VNJgJJE3OPXr/rCVo1J6xKsjj+a/PnKOM/n
         iNKjE5851xiHfI0ZEtbaya+dw8j7ECX/ka5tnlDK65ipKMCTgR62JrlDGXQ8UWLKDOGb
         ghVg==
X-Gm-Message-State: AOAM531zMkDhrpixujqdDD8Gsif6eGK7XKrRCG7lADD45uQ4fUUMwXdk
        3Te64bhVu1uALzhwN3lBs3ClGQ==
X-Google-Smtp-Source: ABdhPJx7eFoWc1+O+6CetQKREpg7NPIRnjV0e41581z4Q7DP0Z44sxvPJM29XYwa37FlshoC25Os3Q==
X-Received: by 2002:a05:600c:19d1:b0:389:d567:e9a0 with SMTP id u17-20020a05600c19d100b00389d567e9a0mr12068976wmq.137.1647534591453;
        Thu, 17 Mar 2022 09:29:51 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm7530217wry.72.2022.03.17.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:29:50 -0700 (PDT)
Date:   Thu, 17 Mar 2022 16:29:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     philip yang <yangp@amd.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNh/Ajxgp3mjvWV@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
 <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
 <YjNNCXc8harOvwqe@google.com>
 <1f003356-3cf9-7237-501e-950d0aa124d1@amd.com>
 <YjNQA80wkWpy+AmA@google.com>
 <b65db51e-f1ba-3a9b-0ac1-0b8ae51c5eee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b65db51e-f1ba-3a9b-0ac1-0b8ae51c5eee@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022, philip yang wrote:

>    On 2022-03-17 11:13 a.m., Lee Jones wrote:
> 
> On Thu, 17 Mar 2022, Felix Kuehling wrote:
> 
> 
> Am 2022-03-17 um 11:00 schrieb Lee Jones:
> 
> Good afternoon Felix,
> 
> Thanks for your review.
> 
> 
> Am 2022-03-17 um 09:16 schrieb Lee Jones:
> 
> Presently the Client can be freed whilst still in use.
> 
> Use the already provided lock to prevent this.
> 
> Cc: Felix Kuehling [1]<Felix.Kuehling@amd.com>
> Cc: Alex Deucher [2]<alexander.deucher@amd.com>
> Cc: "Christian König" [3]<christian.koenig@amd.com>
> Cc: "Pan, Xinhui" [4]<Xinhui.Pan@amd.com>
> Cc: David Airlie [5]<airlied@linux.ie>
> Cc: Daniel Vetter [6]<daniel@ffwll.ch>
> Cc: [7]amd-gfx@lists.freedesktop.org
> Cc: [8]dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones [9]<lee.jones@linaro.org>
> ---
>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
>    1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/a
> mdkfd/kfd_smi_events.c
> index e4beebb1c80a2..3b9ac1e87231f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct f
> ile *filep)
>         spin_unlock(&dev->smi_lock);
>         synchronize_rcu();
> +
> +       spin_lock(&client->lock);
>         kfifo_free(&client->fifo);
>         kfree(client);
> +       spin_unlock(&client->lock);
> 
> The spin_unlock is after the spinlock data structure has been freed.
> 
> Good point.
> 
> If we go forward with this approach the unlock should perhaps be moved
> to just before the kfree().
> 
> 
> There
> should be no concurrent users here, since we are freeing the data structure.
> If there still are concurrent users at this point, they will crash anyway.
> So the locking is unnecessary.
> 
> The users may well crash, as does the kernel unfortunately.
> 
> We only get to kfd_smi_ev_release when the file descriptor is closed. User
> mode has no way to use the client any more at this point. This function also
> removes the client from the dev->smi_cllients list. So no more events will
> be added to the client. Therefore it is safe to free the client.
> 
> If any of the above were not true, it would not be safe to kfree(client).
> 
> But if it is safe to kfree(client), then there is no need for the locking.
> 
> I'm not keen to go into too much detail until it's been patched.
> 
> However, there is a way to free the client while it is still in use.
> 
> Remember we are multi-threaded.
> 
>    files_struct->count refcount is used to handle this race, as
>    vfs_read/vfs_write takes file refcount and fput calls release only if
>    refcount is 1, to guarantee that read/write from user space is finished
>    here.
> 
>    Another race is driver add_event_to_kfifo while closing the handler. We
>    use rcu_read_lock in add_event_to_kfifo, and kfd_smi_ev_release calls
>    synchronize_rcu to wait for all rcu_read done. So it is safe to call
>    kfifo_free(&client->fifo) and kfree(client).

Philip, please reach out to Felix.

We have discussed this in more detail off-line.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

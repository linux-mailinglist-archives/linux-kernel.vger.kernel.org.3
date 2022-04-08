Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A774F9748
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiDHNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiDHNvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54F8528994
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649425778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/8jlF212Dq8hkyxMbM3GcH6GkK/VKjh9OP6Uu7H4G8=;
        b=TRrfZ96TNAreHPN5zqgIztR/XQ48ybbev4Bvrgs3z4a/P/KCsjAO/2KF+A/EN/Vd1290iN
        DkyvCJVScoaObgXBDllYx2vmb3jJ3E36dMXx4fS3BWSqHu86Z+/RdzA/N+Gtev7EvjJPkn
        mSw2MHuB37GDNk/AE12GqRA3dYL1Mmk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-qutjP0mfMQ2lbZyzAAT6JQ-1; Fri, 08 Apr 2022 09:49:37 -0400
X-MC-Unique: qutjP0mfMQ2lbZyzAAT6JQ-1
Received: by mail-qk1-f199.google.com with SMTP id o15-20020ae9f50f000000b00680a61f51c4so3633280qkg.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2/8jlF212Dq8hkyxMbM3GcH6GkK/VKjh9OP6Uu7H4G8=;
        b=A20rCdEXYCRhT9dk3Pabte0T+KXpTVQNNf/ZUK4oi/CvIzYUQoixMqpeRYvSvD+kyP
         1GvjerJzADz4O0haetQ5RtuNtbhfHEY9m87XYNccp8gYO3GY6KYIEdR/D7nZIsuO1pcP
         bLf50lr+EQB9yBOUSaNcR6ywMolb1ueOFqsE6J+7934qRNfA84VJGuVyySY7NWCnlayz
         gWJEB5tnxHMWrw3txm1wBYNsxqRIOuhZsUAJJ68UbCg5e6mqIgwm2a634EENid/IVR6U
         ENBeaBWCN8ITLMz/cXPbyJYo6evejA2ubq3085HikwwfctJv9ixgRkLcqWpxfi8UeNRZ
         wsIA==
X-Gm-Message-State: AOAM532OeSoHvfFwQPYzZ+xJfwag06EeCYZaep1tBnNBfaqUl5UVX9h0
        WgHq2B2XAGb1eToyT2zZYo8cy6ebX3KWmOxmBVLE0h7c3MH/IfdDWxN/12XoaHvX+9tetJDTr8R
        zBIv4/pQeIcQbMgDbRurLm5nA
X-Received: by 2002:a05:622a:64f:b0:2e0:6a11:7b0d with SMTP id a15-20020a05622a064f00b002e06a117b0dmr15799568qtb.9.1649425776816;
        Fri, 08 Apr 2022 06:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywxztvYVFzqW0tZLwRDsrMH8wHvSk844odzCLr7i9gAaMUGLRE8wta2F/K7vQWPD5JyW60Dw==
X-Received: by 2002:a05:622a:64f:b0:2e0:6a11:7b0d with SMTP id a15-20020a05622a064f00b002e06a117b0dmr15799554qtb.9.1649425776626;
        Fri, 08 Apr 2022 06:49:36 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id f12-20020a379c0c000000b0069a048e7f0bsm2802111qke.76.2022.04.08.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:49:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:49:35 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] rtla: Minor fix to grammar in README.txt
In-Reply-To: <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
Message-ID: <6b8d24c-d793-866c-30a7-f015c7babd2d@redhat.com>
References: <20220402043939.6962-1-jkacur@redhat.com> <20220402043939.6962-2-jkacur@redhat.com> <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2022, Daniel Bristot de Oliveira wrote:

> On 4/2/22 06:39, John Kacur wrote:
> > "The rtla" doesn't make sense, change it to "The rtla tool"
> > This is better than removing the word "The" since some packaging tools
> > need the description to start with a capital letter.
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  tools/tracing/rtla/README.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
> > index 6c88446f7e74..3b809eeff5f9 100644
> > --- a/tools/tracing/rtla/README.txt
> > +++ b/tools/tracing/rtla/README.txt
> > @@ -1,6 +1,6 @@
> >  RTLA: Real-Time Linux Analysis tools
> >  
> > -The rtla is a meta-tool that includes a set of commands that
> > +The rtla tool is a meta-tool that includes a set of commands that
> 
> I do not like bike-shedding but 'the rtla tool is a meta-tool" sounds repetitive.
> 
> Does:
> 
> The rtla meta-tool includes a set of commands...
> 
> sound good for you?
> 
> -- Daniel
> 
> 

Perfect


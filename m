Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8B57177F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiGLKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGLKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:43:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179855A2;
        Tue, 12 Jul 2022 03:43:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so6523064wme.0;
        Tue, 12 Jul 2022 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LkU2gFRLGLr3NUPapRs0X2DdjMs6uNNL+JEKLrfvmM=;
        b=p37tJh6p3jzBrc7RSfYgdeoC+UdMrhRRAtBnPD4TeebMqU3kR9TeQQsREN2Ykx2jWa
         oQanbxiOv3iE5/RUzL5eFGza+3XVvDqi34QssZsIm57CtSjkDDMTyn2qHvaU/g78D70k
         3/7RqwsmiQCFLX7EFUp1nz+u1k0lMAm2pwemM/DErMtDIEbDRt+Y8MQw7SjPmWAIU1GM
         Z+SG/q3gnxMxOxsi/ntfcPXcH8sLkK3h0RWDCMI2zM4XJJpJFrOkpN1p4fmMwF4/46f0
         A0ZPx5vhxnbv32ZOyldhCiC+5Od8J6f73kW1jnLp3SqU49K+9TqBxOfdvGHZ4FxHx35z
         ZXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LkU2gFRLGLr3NUPapRs0X2DdjMs6uNNL+JEKLrfvmM=;
        b=R2zRaoIxwA1vNIjSAPMBvpKFN2u4r6QAbHCY0sM5e0/EkueIefvctlZQeo6p1rP4Pn
         I8Am2I+WDDkz+aw+tA0CesjwYFYvsL4TlBS53QDVK5bvzyiO6EfeF3enACL+EIpFSuq9
         lTkjL2QkONM0rm3ogwmxMilddmFyHsGzoZkg8NAnZUEkrgE9A4xOtM5DjM+AxLrvM4wl
         D4Cp11Uioirydd7+jdOnseh/4OKDHLmwhzcZhU9xMwz5G2ZYHaHziZC8bqvKQYCHRXUZ
         eUoIdANeZJT2OZZVaHxGm+aBvYCqbt8TVlhVcjaOr73FfHjz+1vWvel/2FwnX5FiY77Y
         8oxg==
X-Gm-Message-State: AJIora+2upwPPiW+p+II4KRjZZ1EMh3854elbNHlQZborwmHi9WlEKZX
        TfWJnOTRCHhF53Z7zYZSt3VgR9zxZlg=
X-Google-Smtp-Source: AGRyM1u2+dvpXEqINB06jbRUw5pgMwmq2YxooJoPyEYMvvwV81AV3y9Z2PpU0hmB8aDN3beqinF0uw==
X-Received: by 2002:a05:600c:1992:b0:3a1:9252:c373 with SMTP id t18-20020a05600c199200b003a19252c373mr3025423wmq.140.1657622619200;
        Tue, 12 Jul 2022 03:43:39 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id q5-20020adf9dc5000000b0021d928d2388sm7962308wre.85.2022.07.12.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:43:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH 0/3] staging: media: atomisp: Convert to kmap_local_page()
Date:   Tue, 12 Jul 2022 12:43:36 +0200
Message-ID: <2264743.ElGaqSPkdT@opensuse>
In-Reply-To: <20220709174645.080fc795@sal.lan>
References: <20220707200718.26398-1-fmdefrancesco@gmail.com> <becfe58a-b4c3-4ae1-4ab2-456057ac7d22@redhat.com> <20220709174645.080fc795@sal.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 9 luglio 2022 18:46:45 CEST Mauro Carvalho Chehab wrote:
> Em Fri, 8 Jul 2022 17:55:26 +0200
> Hans de Goede <hdegoede@redhat.com> escreveu:
> 
> > Hi,
> > 
> > On 7/7/22 22:07, Fabio M. De Francesco wrote:
> > > After waiting months, I'm resending three conversions to
> > > kmap_local_page(). I'd like to ask if there is anything which 
prevents
> > > these patches from being accepted.
> > > 
> > > Please note that these patches were submitted on April 2022.
> > > 
> > > For you convenience here are the links to the patches, the "Reviewed-
by:" 
> > > and "Tested-by:" tags:
> > > 
> > > [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
> > > https://lore.kernel.org/lkml/20220413225531.9425-1-fmdefrancesco@gmail.com/
> > > https://lore.kernel.org/lkml/Yli+R7iLZKqO8kVP@iweiny-desk3/
> > > https://lore.kernel.org/lkml/2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.com/
> > > 
> > > [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
> > > https://lore.kernel.org/lkml/20220413212210.18494-1-fmdefrancesco@gmail.com/
> > > https://lore.kernel.org/lkml/YldNhErgt53RqYp7@iweiny-desk3/
> > > https://lore.kernel.org/lkml/0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.com/
> > > 
> > > [PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
> > > https://lore.kernel.org/lkml/20220408223129.3844-1-fmdefrancesco@gmail.com/
> > > https://lore.kernel.org/lkml/b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.com/
> > > 
> > > Fabio M. De Francesco (3):
> > >   staging: media: atomisp: Convert kmap() to kmap_local_page()
> > >   staging: media: atomisp: Use kmap_local_page() in hmm_set()
> > >   staging: media: atomisp: Use kmap_local_page() in hmm_store()  
> > 
> > Thanks, the entire series looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Yesterday, I applied all pending patches at media-stage, including those. 
> Please check if  everything is ok, as I had to solve some trivial 
> conflicts.
> 
> Regards,
> Mauro
> 
I just checked those patches at media-stage and everything seems fine.
Thanks for applying them.

Regards,

Fabio




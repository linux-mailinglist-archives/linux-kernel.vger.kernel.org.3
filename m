Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B5517577
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386527AbiEBRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386589AbiEBRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F4C5F9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651511330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUwB/ObsvhfAeYdc94J/vluBprubJpnzEDKGgG5UEn8=;
        b=FRd6+pJdhtZon64Y3NeRLl/sjZU/Zcvy55kots7U3fXU1kRqEfhVdHbeB4kiZikXT59A0l
        rCqc0YUD2KAL/3FJMa9soBYbIXwAbvB0fQM7GDzHXkXNI4ZhrdGjF7Cxzb1r6bVQBKPwpm
        urhKWn0nALXGGVSg7Jjz4ZfuOwBRkBk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-PLfMYHmyNxq4YtixRgr5Jw-1; Mon, 02 May 2022 13:08:49 -0400
X-MC-Unique: PLfMYHmyNxq4YtixRgr5Jw-1
Received: by mail-qt1-f198.google.com with SMTP id f18-20020ac859d2000000b002f3a0c971e9so3818457qtf.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUwB/ObsvhfAeYdc94J/vluBprubJpnzEDKGgG5UEn8=;
        b=eO16u/QyyucZM3oLx5jgmwgSWyI20C0RRMFwEDcw6ngKrOJKSxFFoK/t8NDCHWaH2f
         2l9DD/PLOaEgAvMsmgXOCEYlzhLXuBhGOrDJ9R1+yDNaO+eVY3wHDJ0fMuAQQHeaDBsy
         OGCnWWjFKw5ZTAfwokhUW3VL+alSys+Yk14oAJ6fSFQeZr1gigRqSLT6MiGqBWvxmNs7
         HTWVL/xWq4E34GwJD4BKqT/VM10RDKWNPjSG8NOBrjUAeMzB7iH15wxyVjOtk9yUIaXa
         I31Q1HvvsGmoAgbzxDfiQtcglpXi28RFJgUzafjEHeA/1R+90cPsX7CegMFBd2Bis/kx
         nQaA==
X-Gm-Message-State: AOAM5314kAZtQlMensFMwm79o+qc51gtM72xJulBxwYtOokzJIYcUZ0s
        lAxQscZ+MaI6cNCyiA1L+JQHvknkzmR/keoOpyojjsefEXDFZ8WCrXegZDQCJFb8/9fk8+Erda0
        Y3LV1KqAJs5gzNEGwfHQfslr1
X-Received: by 2002:a05:622a:1012:b0:2e1:e7f3:5c89 with SMTP id d18-20020a05622a101200b002e1e7f35c89mr11191067qte.550.1651511328821;
        Mon, 02 May 2022 10:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1uiEQOy0AttuZWwuG2nj7JekcJUIdCT/k4msCkxiX30JIboupy20ctm7seHGiEzL9f5Z53A==
X-Received: by 2002:a05:622a:1012:b0:2e1:e7f3:5c89 with SMTP id d18-20020a05622a101200b002e1e7f35c89mr11191046qte.550.1651511328621;
        Mon, 02 May 2022 10:08:48 -0700 (PDT)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id bq34-20020a05620a46a200b0069fc13ce248sm4606429qkb.121.2022.05.02.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:08:48 -0700 (PDT)
Date:   Mon, 2 May 2022 13:08:46 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] staging: vchiq_arm: use standard print helpers
Message-ID: <YnAQHjPVSIAh6hOj@fedora>
References: <20220428150550.261499-1-athierry@redhat.com>
 <3b57224b-41a2-6393-51b8-a9c3435fa4d1@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b57224b-41a2-6393-51b8-a9c3435fa4d1@i2se.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Stefan,

Thanks for your feedback! I will submit a new version that addresses it.

While rewriting the patch, I realized it might be easier and less
error-prone to remove some global variables before tackling the logging
functions. So, I will submit a new series for this first, and after that
I'll send a v3 for the logging functions.

Best regards,
Adrien


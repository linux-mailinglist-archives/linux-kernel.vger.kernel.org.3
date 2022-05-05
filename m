Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A951C6DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383060AbiEESR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383052AbiEESRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:17:18 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661D25D1B8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651774414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIQ6rERKH4luifLFHwoZPkiKhXSs2wHfoxIuk8Um0/k=;
        b=TLNDTprPjPH19mgtlKi7WWzndGSNbw1k2jG+4k8JIrrCqIxVTcsJvFz8/4P/xPoi7aFxcD
        31mQ3REts6rNBGfJ1YSeXW2buDHtgUukzqrf+Vxoico7rrYOVkNAMH8zVNYr7q+uTSNraj
        689a4VGODemT1ya8b4yVdphXet/dBGg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-qaLVb_EYND6U8hRAa-kWmw-1; Thu, 05 May 2022 14:13:32 -0400
X-MC-Unique: qaLVb_EYND6U8hRAa-kWmw-1
Received: by mail-qt1-f197.google.com with SMTP id t25-20020a05622a181900b002f3b32a6e30so3958913qtc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIQ6rERKH4luifLFHwoZPkiKhXSs2wHfoxIuk8Um0/k=;
        b=wAv7byU+QJdEzj/mlXZO163Em+43ZPz4TgWLz0Qj3YYJXIYmk/gfnzylY+4wLoGKGm
         AmvutdEEQqIsg7Skrbf99/sob4mdKXJkpMdg2xp/Kf58vjIP4Q0LOiCNHdLk5bvCCjkB
         nf5CuiYbquE0OjNyw35pZHq7f7ydSoFJX0d0ujL7/qTAsL4YLaM0twNPop0MLkL9AK3v
         xrdH+hNbiotthawS/m3mQXPZ4VrzCQqNMHmSwYpFRiH4heZSP8ZS1Jwt8RypCE7l0ybO
         91CnfPLHnoxpV+V+CcAsDs5XmnH4eA/kXKaGyb7yag+BxHmBJh+VLy1qkU6r06WubX5t
         jKMQ==
X-Gm-Message-State: AOAM531KQptckN6AC1G+Aq04W8ELvdclHznxr1s4GDGDKzFUC4drevS3
        OKzmctQwSEDVd8lPeyACy5XV9CBhXbxk4a66r4q38mmhGu7s6oPK4yZb9hW3jRmcPx2SGanyTZX
        PFo43/GWjG0oJbCS4STufogRS
X-Received: by 2002:a37:9342:0:b0:69f:b0b9:b60d with SMTP id v63-20020a379342000000b0069fb0b9b60dmr21180454qkd.728.1651774412135;
        Thu, 05 May 2022 11:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZDVSrYF0/IHka2CQ1470+9YJmZLCgwnZ+Aoo3cSeAePgqRTe09cEGUHwjWj3klSG0nnBjLg==
X-Received: by 2002:a37:9342:0:b0:69f:b0b9:b60d with SMTP id v63-20020a379342000000b0069fb0b9b60dmr21180443qkd.728.1651774411955;
        Thu, 05 May 2022 11:13:31 -0700 (PDT)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id i22-20020ac871d6000000b002f3ad89629dsm1230752qtp.2.2022.05.05.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 11:13:31 -0700 (PDT)
Date:   Thu, 5 May 2022 14:13:29 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] staging: vchiq_arm: add reference to vchiq device in
 vchiq_state
Message-ID: <YnQTyS+37rTkvQ4/@fedora>
References: <20220502183045.206519-1-athierry@redhat.com>
 <20220502183045.206519-2-athierry@redhat.com>
 <60a0ad1e-92d5-5032-7672-3da9ea606348@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a0ad1e-92d5-5032-7672-3da9ea606348@i2se.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

> the patch looks good to me. It would be nice to mention that with adding
> the device reference it would possible to introduce common kernel logging.

Sure, I can mention this in the next version.

Thanks,

Adrien


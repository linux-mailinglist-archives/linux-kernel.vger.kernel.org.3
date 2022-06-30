Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3749562394
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiF3Twq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiF3Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18B54443D3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656618759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6xqv8hs+XRgwjFSDNBYvhusbDhaYngjQ59D9YVxo8g=;
        b=bA2kSgjHSPTsc5ub1XnKsushvrd6jkycReQ9+rKpI+Ge65Bv3ADrlNjfLm2hlBDihQ5f0d
        +pKQoGq47aO1ELdO01wVG/vU3FL2K7JUxkkUbWfM+8MDP78VI4zyc+1DFnA7QC0kq8VE+j
        pIzNODGzdjNTAiRfKjMoCoOmZLlvLWo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-NXJQJwhJMnOqFbtM61eodA-1; Thu, 30 Jun 2022 15:52:37 -0400
X-MC-Unique: NXJQJwhJMnOqFbtM61eodA-1
Received: by mail-il1-f197.google.com with SMTP id n16-20020a056e02141000b002dabb875f0aso43540ilo.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Y6xqv8hs+XRgwjFSDNBYvhusbDhaYngjQ59D9YVxo8g=;
        b=jZApNz0snq0YtYGSn7Vf1Q9aLRalgRZFm0GkZxortn3y50JB1tik/WLMxkmbLuQz2T
         ArjvZ2vT4TlacuCXyWEimKjiwDDRh1nEtw8T+eDVqKuaej912CRirwiIyyTLv/NqoCHw
         yLB2ry/x3MraSH9Q0xYta4s68YSQiJ003mKp7Irn0keWAdliPfFcLzS1ocfJwoChB8XS
         o45QvLXKGlmHe8Iht60it6EI+TfEO48XN6Tbf/wFRUrvV3chI0z9MusE8R844LxPuCwd
         SgM3WBdRhaZxLR5HjJfgKGSNnNQAMNZxIYEuDhpfChO+FKIMzrHER+77woWK2xZsL6JC
         N3kA==
X-Gm-Message-State: AJIora/kbNXhg7i0pD1DzWcvziwUl/ctUtHExho8HSa+yRY6x5lyulZn
        FxCxgYyZvZD2K14JrJJvNYTumegZNd7WdTdGlbeuA0F2zzXCGvzabK6p5YnJv66+oVZNHAqamNG
        nIlphaXczVVKTSf4nkbzs8x+v
X-Received: by 2002:a05:6e02:1a68:b0:2da:9b52:28c5 with SMTP id w8-20020a056e021a6800b002da9b5228c5mr5618981ilv.253.1656618756969;
        Thu, 30 Jun 2022 12:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vVE2mrAWAgc5A5eRbm90N2mWbOhnx1f03iIjBRSRBRlLiVaiEN67U+EQ/COzeFWjD9VC1efQ==
X-Received: by 2002:a05:6e02:1a68:b0:2da:9b52:28c5 with SMTP id w8-20020a056e021a6800b002da9b5228c5mr5618968ilv.253.1656618756764;
        Thu, 30 Jun 2022 12:52:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x42-20020a0294ad000000b00330c5581c03sm8880286jah.1.2022.06.30.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:52:36 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:51:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vfio: Clear the caps->buf to NULL after free
Message-ID: <20220630135140.2dd079c9.alex.williamson@redhat.com>
In-Reply-To: <20220629022948.55608-1-schspa@gmail.com>
References: <20220629022948.55608-1-schspa@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 10:29:48 +0800
Schspa Shi <schspa@gmail.com> wrote:

> On buffer resize failure, vfio_info_cap_add() will free the buffer,
> report zero for the size, and return -ENOMEM.  As additional
> hardening, also clear the buffer pointer to prevent any chance of a
> double free.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> 

Applied to vfio next branch for v5.20.  Thanks,

Alex


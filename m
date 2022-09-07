Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5B5B0A01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIGQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22915C9CD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662567962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpRcSEjb5EFxGfzHz+GWr2U/0UjWu0SzaZNMoqBv2RY=;
        b=PB17JnJFiIeLYQrOg0HzqpxfTEU2DtuTRtH7lTOSZCe4QYkdC689aqkvdP1hx5mc7nYt6a
        CIQhKsJp9Unrzp8qmpnEwsI6JApwpctDAnuERCZ8yRSswNsodxHg8oa7BlDtMdQLe3lSN7
        uPpnfUlNxU3GkAstZ3NMEW/A/B9aup0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-Ne7QdE8UONWl9CBH89dHLQ-1; Wed, 07 Sep 2022 12:26:01 -0400
X-MC-Unique: Ne7QdE8UONWl9CBH89dHLQ-1
Received: by mail-pg1-f200.google.com with SMTP id 136-20020a63008e000000b0042d707c94fbso7683743pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=IpRcSEjb5EFxGfzHz+GWr2U/0UjWu0SzaZNMoqBv2RY=;
        b=BAJM9Qa6hjsuHT8OQkFC56mzKscERANjRIS2QBO5eMQfUjg9RkclVkOjDzAq9UKEJb
         qvbBL0wXKPuW1xq5qb6VED3YlaF0i9ZGzQHNItvkVo2vkc9upMfKhSOnRw+/yQ8Q09AH
         PymGGyqqbLd3yYwet622Mkcr2oHoTwx7UN4dRsYgHM1pYiQQM1i9TCb9OrrIH9NVBmE6
         sygipgrAvy0eJVwoeR1AunJMHlhicrqwcgSsCoq7WMOVc5ew/xWO8zXSNhsJVHsqslgp
         TshgyEDQ+0oDK7W841T83rbrteeDiic7Y49F0TNlyq3W8KL9ZFAZPMFiv+TjFUSePMwk
         DVQg==
X-Gm-Message-State: ACgBeo1/q7lTHU8WbbpLv35PwJiZANRKSOb61ldd/iTe3y+027CTr+bR
        XbCVOdNawQ3961UbuOJfQCz1aPWPbewSbqGkD0MaKL6GNWqmAC32Vq0CRNCGeexSN5/X1VsD46O
        EiJFRY3MI2PVt/rX0YNcchhXc
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id z29-20020a63191d000000b004344bb3e016mr4186526pgl.133.1662567960399;
        Wed, 07 Sep 2022 09:26:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eEwwovNfgE+y8ahTg/s4MoHLKu77bE6/7AuVXsn/mNT13uNFKTeavslC0p5M82+XxmK5z8A==
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id z29-20020a63191d000000b004344bb3e016mr4186514pgl.133.1662567960128;
        Wed, 07 Sep 2022 09:26:00 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090a654400b001faafa42a9esm9245843pjs.26.2022.09.07.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:25:59 -0700 (PDT)
Date:   Thu, 08 Sep 2022 01:25:56 +0900 (JST)
Message-Id: <20220908.012556.1223002692465040215.syoshida@redhat.com>
To:     sven@narfation.org
Cc:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Fix hang up with small MTU
 hard-interface,Re: [PATCH] batman-adv: Fix hang up with small MTU
 hard-interface
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <42632958.r4OcKK3suL@ripper>
References: <20220820032516.200446-1-syoshida@redhat.com>
        <20220908.010037.1643964170435041362.syoshida@redhat.com>
        <42632958.r4OcKK3suL@ripper>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, 07 Sep 2022 18:04:09 +0200,Wed, 07 Sep 2022 18:04:09 +0200, Sven Eckelmann wrote:
> On Wednesday, 7 September 2022 18:00:37 CEST Shigeru Yoshida wrote:
>> ping?
> 
> This was applied a while ago:
> 
> https://git.open-mesh.org/linux-merge.git/commit/b1cb8a71f1eaec4eb77051590f7f561f25b15e32

Sorry, I didn't notice that.  Thank you so much!!

Thanks,
Shigeru

> 
> Kind regards,
> 	Sven


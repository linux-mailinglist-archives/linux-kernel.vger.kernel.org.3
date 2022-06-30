Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF356170A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiF3KCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiF3KCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5A43ED1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:02:02 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2787A423E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656583321;
        bh=wIYh+/Ozpb80cqbgI0j8SCGA1rmqDwRVQ0ZfOk2tveM=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=U8UBGrok+rn2qhWkkUpQ35TJpsmwAFaWwQZgPBjWo6UTp6m22wRlzSq55RPH7J4os
         X6+3ARDCOiXhgB+OOvplwT8GsrT9rpHdSWE/SGqTfqIVpFHef2C0MxUN9ndTjGcS9Z
         20ayRuZsCBkET4kllbKuFdteZBVI6FnSsbcEOLP/maavd/gk6oHHR6n+LMRBLNg/BZ
         Y3o95QNZTKFpxOrlA/zwCR68kfeyJAffZcW1XguYxLwahRBcxELNyVYVqfLfbL0X5r
         LpayKBRlKG5IVVoPosO09qLwiVzEmFO8MzUjkr4B/ER7TiaVVIEU9cJX38uWmBTh8W
         T+Nd0VJ770j0Q==
Received: by mail-ed1-f71.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso14107387eda.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wIYh+/Ozpb80cqbgI0j8SCGA1rmqDwRVQ0ZfOk2tveM=;
        b=YYinnhw1UKSaFB5QlZ0pJzqhKA58IdwM5RXpSwZKQu9qB975ldrpvLurKE/e0LoRqs
         OcREVDMMovUIZR32H0i/lxiNmxLxZ0b42rvzXelN4zH8Ab16d7cn1gdjsoLMoNYoMtJ4
         inY9+g+0GJAVqmvLbVwJFPe48cx4rwqMoAHtqLhm0zkVgbPlbbXlOaOg2OgKvvTAAOVJ
         TOh8YqdsqLRN2aK4kGXVhYEfbb/o/TfpLT6e/Y8C5IjmDyibajccHJ+H3L3MvV0Qz1iB
         sswJWSpjDka5NwjTbnGJtGntAUDoBISvZrN1HsN3ZT/IkqNtFw3mz3TeSMXiavhO2wss
         Hbsw==
X-Gm-Message-State: AJIora+l5EW6u5o0bI7GStOOE1Ag9A0ubLzh26P5d5XfvIDdewCiBD5f
        vYSKHxy4fmYkBaBOs+5r0sM74MbqblfWvhOsrJUvqifx9oJojo0xpdaXRSu6oFffaTM8i0vtvgk
        yf96bM5k/YF71zxNXgc++KZt3GGk7l74g4ucNIGU/SA==
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id p6-20020a170906614600b00722f8c4ec9bmr8477893ejl.708.1656583320339;
        Thu, 30 Jun 2022 03:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vdDtvXrzIADOYaPgD1LYAc9jmzgUxML4F7NW1hAVyacDhmAXcIjpfNz5/zgEYUzHTVOctNRQ==
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id p6-20020a170906614600b00722f8c4ec9bmr8477878ejl.708.1656583320184;
        Thu, 30 Jun 2022 03:02:00 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c03c])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b0072629cbf1efsm8828502ejj.119.2022.06.30.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:01:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:01:56 +0300
From:   Cengiz Can <cengiz.can@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Wondering the reason why __fput_sync is not exported as GPL only
Message-ID: <Yr10lO4vDLiqwLX6@nexusd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander!

While backporting a few commits from stable to ubuntu distro kernel, 
I noticed that `__fput_sync` in `fs/file_table.c` is exported as
EXPORT_SYMBOL rather than EXPORT_SYMBOL_GPL.

Since I don't know the details, I wanted to ask if you know why.

There are certain OOT patches, in circulation, that export this as _GPL
and I'm not sure if I can convert this export to non-GPL whenever it was
exported as GPL only.

Thank you in advance.

Cengiz Can



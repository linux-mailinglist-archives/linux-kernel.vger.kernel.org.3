Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42894AD143
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiBHFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBHFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:51:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E9C0401DC;
        Mon,  7 Feb 2022 21:51:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so1606031pjb.1;
        Mon, 07 Feb 2022 21:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3ZcLJm27H8oLNAua0asYIW8shnjHdO4o7eaON3JmvI=;
        b=Utsof/n07Dwv/VAN0QG8C3UMpXsvFVUW5T873C1nhjJWvcGJJvT3Z8el2TgAX3GiFZ
         cuQfk1uHldSvLZucfShn4G2jJ3WrRCbr5Ca6l2A6+8HCcxT2T5ztNFmVO2p2roDNbd3/
         XyE/XWgT8hy5is8hITgRVUz0RwUp12j+8Jm8mbOxH/tLNBfo2HjypUpr5RCd1mo9ropv
         8YbEZzPtXgeeLDORVTlI7pK3LazDFh+JTkg6cx59SfANFbIv8JeZWKiC/BooY7/Sbk+W
         uCPF9TlPLiXIUXKHpZRbmSfdV3wZf7S6M2A0gmu8oVXuQZvzIErsK+5Kls7cTf1dKs6P
         F0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3ZcLJm27H8oLNAua0asYIW8shnjHdO4o7eaON3JmvI=;
        b=DxFDGfqLbx95mPG2CYKCrKG9rfJQgw2iBETtYNST5a25luoCOQKElFZ7ekyT+AeoyA
         9UvDh+vAUrlzRRCYUbXJE7SyIm51ioGJ5R9RsAZRfd9Y7AEGzu0Hm/Y5+7imfVIoJxVZ
         l7ILzN0HUP0SW6USVU1yzkiZOQ8eTJok1eTOskxALgQzHxmWVu4/BeuP122VSrMPoCyL
         2vEdeHzK2908Aj7sA7azzkcyxbRXwtjvQAMGUF/gQ9f5Lhv32Z9AwhK+BTRkEVYcKVlJ
         7r6nTfBE8hS3o8YdlUXDxYOgiuLzTfvXgj8gWASRZErj0p/wl6lXIya3X03H5EAypYwa
         oSPg==
X-Gm-Message-State: AOAM531v25wO39p7tI+bYmzLjhxzTU6Z5sECvJnjbct0JAngu/RLXJUF
        2OtpoJqzXc91Xu8EttgcgQ0=
X-Google-Smtp-Source: ABdhPJzE85kiG+7OF7zdzg8yZmLKGSLdEq8VpQLCjB1TKj93dQ7lNK3LG1gtK6qTcVDD9IcAngcFaw==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr2638034pjb.71.1644299501213;
        Mon, 07 Feb 2022 21:51:41 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7164:d581:d7ee:53bb])
        by smtp.gmail.com with ESMTPSA id mp12sm1204652pjb.17.2022.02.07.21.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:51:40 -0800 (PST)
Date:   Mon, 7 Feb 2022 21:51:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Input: mtk-pmic-keys - use get_irq_byname()
 instead of index
Message-ID: <YgIE6ZVNFPS1ffUR@google.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
 <20220121140323.4080640-2-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121140323.4080640-2-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:03:20PM +0100, Mattijs Korpershoek wrote:
> Some pmics of the mt6397 family (such as MT6358), have two IRQs per
> physical key: one for press event, another for release event.
> 
> The mtk-pmic-keys driver assumes that each key only has one
> IRQ. The key index and the RES_IRQ resource index have a 1/1 mapping.
> 
> This won't work for MT6358, as we have multiple resources (2) for one key.
> 
> To prepare mtk-pmic-keys to support MT6358, retrieve IRQs by name
> instead of by index.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied, thank you.

-- 
Dmitry

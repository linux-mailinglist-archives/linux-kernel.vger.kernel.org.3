Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F094E896B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiC0Sxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiC0Sxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:53:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087AB11C0B;
        Sun, 27 Mar 2022 11:51:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p22so14688049iod.2;
        Sun, 27 Mar 2022 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I+2ns0un2e60TlXXzfgEVDdONbJVSoJmH+3QGKhKNM=;
        b=pLYaeKfFYg+eu6o7YPDnD+gtmlzQrB1Ri/UH6Ksemjj9NlvLCb3h7Vjoo7fo8F/AE7
         Vv2XuFVNrbti9HTM01Y5PfRaTnm3qiTql/FtfLDHwd0Xp7pMsO6j4ygtXpaQvc63mQ7h
         9fonCBXLVN9E1wSPxJ8d/IdPh2jk0OHbbV2pD1WMMDL8Bx60jYy4IP2BOK/mKp2mu2EW
         eG8z9TPGoCpnM83rQk3BUVRzuU4yXFKZt7aabmkMTgONNWaN8O2BXCJaaiHHapmDDWRE
         1ScubAqDP/gLDDLz8EvUXxGV0NaQVZkS88OTAU0sfgOBtkGMe6/2HXyTn66srKNLr0Rj
         cS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I+2ns0un2e60TlXXzfgEVDdONbJVSoJmH+3QGKhKNM=;
        b=nHloiEtlMzzf243sV0Jim1yLbzreE2O+Gz0669RDRgp7meHOCZU0vNLaguXiL7+oic
         dKTY4xY79e+wGN2cZamnxAhx/8MklRmdq9xOevKu62Ep3Jq8DicVbzzwjnbpqrPjWmex
         Cq+Ua+U17wKzzSVDXH6FmJdCULigA18c21ssMxq7kfoVf3NPooZmuRRwNeQL9w+FwFu4
         YBrhtxdF7/opSom2IJ4KPlirzMW/ZyNKT/zUEPxNf4lOK+joccUezRfm96Ze4v4WZnQL
         vLBi6bgEIrBy4OMrQF9yWCWLLvXke0a3vplNa3+4FHf1AlGX4URZUj/XwIXdcUMC3fOK
         he1w==
X-Gm-Message-State: AOAM531AUMoIkLSXSQy8ZrU+M6ZWxdJkgoZL7fHpdVUFl1NWntYZt9/r
        lRS/xMBRPcacPJQ0bIzKDkXHTzDGSvSe2rkaOhMZIAoR
X-Google-Smtp-Source: ABdhPJxbtXAcVweEeYoLpLzEzFIdDk9c9agfXcXi6WPaWcL6INT6GlZQ9rqnHsjVVh7DQpHyA+DMqbkeZ8+6JVMYcOc=
X-Received: by 2002:a5d:9d44:0:b0:645:b6e9:4bbb with SMTP id
 k4-20020a5d9d44000000b00645b6e94bbbmr4688865iok.77.1648407113439; Sun, 27 Mar
 2022 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com> <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
 <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net>
In-Reply-To: <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 27 Mar 2022 20:51:42 +0200
Message-ID: <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 at 20:04, Guenter Roeck <linux@roeck-us.net> wrote:

> What is the problem other than that the string is split across
> multiple lines ? That can easily be fixed by not splitting it,
> so you'll have to be more specific.

Yes, the problem is that it is split. When merged it exceeds the 80-th
column and creates problems for editors instructed to format text on
paste. And I would not like to neither split the string onto two debug
messages, nor shorten the debug message itself. Maybe there is an
elegant solution I'm not aware of?

Thanks,
Eugene

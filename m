Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E95B2BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIIB4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIIB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:56:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42F115CEC;
        Thu,  8 Sep 2022 18:56:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m15so287866lfl.9;
        Thu, 08 Sep 2022 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C6GdPeseyZ47mkJgGAMYjW342mQhHM0z247mo906Lt0=;
        b=VFpsO4Xd9qS7WEq3gGU5chiGpEK8QeP6V6vm2Z63RunRLxtsJXkb3QiOj6Ol3Mvwft
         ycqWRpe6nmWrqfd3xoDcHTGVfqDP448HDWnKLAsRw09rC4AtNQTCYJ0s3ChcyzWxkav1
         +o76reDHPSbnCB5pwmXYssnKB/Dt8q3JEWSTtk2VhFP4g4+hq/uMnpLcBeXfubFW0zDI
         f2eATel9Mo9q65oCj49JPe+B1F1cxU02LYpCe/4+LTI5+O0jHg3z9EElmzu1dhSYglCV
         gEezAm4WF8OOV5dM5UQXBRg1+uT+TdKKhP5wtSDXkKoVHSTmDN1B2TGwgfTyCZRRgw6y
         p4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C6GdPeseyZ47mkJgGAMYjW342mQhHM0z247mo906Lt0=;
        b=4lvvNhiNcmJv6WhvCAyCoP2yqpCOjqpRE+gBMANP1Hene78H2wxTpbD+yCh6MJRMST
         WJ2Ib65MvZAMiwXE3pPCT1c58YcLMO0R6/D6hthW/bwK7b5nAhZDx7UmLlVty4eREg22
         +pA/BP2s7QFFDEwtGNlW6q2Lqb9btkq5XEQII53AKMNTpx/zkfZ/86VqkqIgIlgzmVQG
         qUvDw2S5DUkPfz7BHuEKYN83KBwDJLDbyqW7TogVvCToPIHQnejzXGaI92S9RZKeCyXF
         gsFiFOOF5v6vF/62YRDsuzJAey7rJqA4+PqrrSh58wO3P+24QX0uNm1opIRQDL/JiEU9
         Dd6A==
X-Gm-Message-State: ACgBeo1V/89dy8s0jEri81Xr7SrN0E31pddbkLmxbmJ0u7X1UZPj6PN8
        QvEmR+wsyLN8oAqdBrCFjyvvIGvhpKwRkQ==
X-Google-Smtp-Source: AA6agR6kF66uJ3M3zDHsaGf4VKe6KLsLiAKewaJ9J/py2Kb37gxAmbuN0hJ/Oz19mmxVpYNRZtNJZw==
X-Received: by 2002:ac2:5d26:0:b0:494:6d31:4c5b with SMTP id i6-20020ac25d26000000b004946d314c5bmr3798920lfb.358.1662688596625;
        Thu, 08 Sep 2022 18:56:36 -0700 (PDT)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b004947a12232bsm52810lfr.275.2022.09.08.18.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 18:56:36 -0700 (PDT)
Date:   Fri, 9 Sep 2022 01:56:31 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of/fdt: Don't calculate phys_initrd_size from DT if
 start < end
Message-ID: <20220909015631.385b0781@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <20220908160519.58041-1-marek.bykowski@gmail.com>
References: <20220908160519.58041-1-marek.bykowski@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Sep 2022 16:05:19 +0000
Marek Bykowski <marek.bykowski@gmail.com> wrote:

> If the properties 'linux,initrd-start' and 'linux,initrd-end' of
> the chosen node populated from the bootloader, eg. U-Boot, are so that
> start < end, then the phys_initrd_size calculated as subtraction of
> end from start is negative that subsequently gets converted to a high
> positive value for being unsigned long long.
> 

Apology Rob, I confused the description saying that it is wrong that
start < end. The patch was correct though. I'll send the third version
fixing that shortly.

Marek


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCF4F1BC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381202AbiDDVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380014AbiDDSkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:40:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A731376;
        Mon,  4 Apr 2022 11:38:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t4so9075993pgc.1;
        Mon, 04 Apr 2022 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmPEcdivL57AHBLd508ovnXtC12+S9213cbQAz9S8ic=;
        b=M6CalxvceL4+5dUPlDgTcpz+SZHVr2Iup8ARhfwK52cBEwckqeILRI4pJeg65UYsOw
         rGm6pmRFiXrLVRLgUkPjH8HQgtpslRTtQ2pvKH8Q8PPPhy1A4KBqfcAkM+eIWBGiWu+d
         8aXbODxZYc0VNW4GXXVPeOTNpZfaGPn50UF2cDg6A2YDkph6SmBs2FidhUKnRI0Y58As
         kK5YPSjmQ9EgFhaMkEwwFF6yONhkfHDLbctyde06l5jImpAarQRxYvz+QGwL0nwSkqfF
         GblDI3EV69YBSJxLmarZNmYtzULvTZwny87406fgVCe9ygIWHYiUFo9lcPhU9hAz/oxz
         FuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmPEcdivL57AHBLd508ovnXtC12+S9213cbQAz9S8ic=;
        b=dCTZSBSAQ2h2JcP/PY8soG7gc9gDMfMr9mUEU0bHgV6qYfEmMX4fxikUbRBxqZq+8k
         IN9vC6EEbZSO/7Ne3ogmNXdWkqJZSzWiZcw4lXgx2kqKsq+t9IKT0IzWA+jv6HoV9CaW
         R2q8h/v19hzXgkEDg+/BoTHSRSe/3A7atR6SzjI8sdUhztbC4HmTAacJp4Wunwf6U6XG
         yMfdr3bxdH84qIT5frbDcRr/pLVeuqpOlgcgGyVjrVW5RKZP50GpdNS/oJ0+SRNpxR9r
         BsfdhlLdVWoaVP+Yk6s+PHqydBzjUbcm364ltOJ+FoBuhU+KnAvNEKqMSLQU4GfAqv97
         Xf5A==
X-Gm-Message-State: AOAM530km6pzIiazRAvVeG8ivtXxKQx/zy9X+v8KNXh0MvB3R7Nc2qC/
        Gfcq/89SV/Sz5EwVSLR/+zA=
X-Google-Smtp-Source: ABdhPJzPaf4VTLpNukbM1Yv1qb2p3n0hHcWEmlyRo2W9YT4jfy4ViSIoxPmsm+GnzOWRndKWXEFgtA==
X-Received: by 2002:a63:af06:0:b0:378:3582:a49f with SMTP id w6-20020a63af06000000b003783582a49fmr1025532pge.125.1649097499045;
        Mon, 04 Apr 2022 11:38:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f31-20020a631f1f000000b003742e45f7d7sm11148281pgf.32.2022.04.04.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:38:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: dts: BCM5301X: Fix compatible strings for BCM53012 and BCM53016 SoC
Date:   Mon,  4 Apr 2022 11:38:16 -0700
Message-Id: <20220404183816.2317832-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-3-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com> <20220402204622.3360-3-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Apr 2022 23:46:21 +0300, Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> Fix compatible strings for devicetrees using the BCM53012 and BCM53016 SoC.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

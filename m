Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4B4AD147
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiBHFwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiBHFwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:52:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE44C0401ED;
        Mon,  7 Feb 2022 21:52:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u130so17068011pfc.2;
        Mon, 07 Feb 2022 21:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLuzhS9mpAsa68IzrkcFELBJbuL/U6yaQdmHB+sIbmQ=;
        b=pJ5k9u7DsQhT4m3WLMULPqmPvLDCOPemnJy+LVyt6UblDhM3h+9ChipQWwkxML/qmL
         qIcROrJ1tGf4Rwd0i3idG0eGzmhkYgI4I8m/JlfHflITQnaDcv8+xbQdXM0gWTr3HpxK
         h1AkXmEHQOgpUjUaV0PsFuUMwCw6bkA0XMu2N6FfobRYE+VKAtyApH9Fv7jE4lGY+EOX
         byXzhqzEUVoxGJpFelZMOQp/SJ/nM6nFv7tc8eGcVLax9/silgoJJ7UXwczEhsMeyaZW
         8+TvU2SCcA0YwWXtI8pOEoQr0JhwKJ5UOXpvKdD6NtPbCrm7dFH5DJBqBhIGRW1RKqtk
         rqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLuzhS9mpAsa68IzrkcFELBJbuL/U6yaQdmHB+sIbmQ=;
        b=0zISPWDPY3hAeX0vYi75TJ+gbjOFVD7z5KdDWMMYul2F1Q9fg67doF3HgQtTmwlrO0
         C6dAF4mc753et/OBpaQDMxlmp7JB7fPd9NyUI25ty0mr1mzdKe+B6wtq1Kh/ZVvUV0Yu
         Kvx6JRxINv/2UQmn85GxQvvg1iNNqf1BbTTlC0pWApzDdDJFDOde5Hp77p1LJzbwleZ6
         Ee7ZlT4TAkg3dhG/EhA5N1d78rB9LzMbxP+9uI4Hl3uSpaMPvtxcgU6WexPphktQavf4
         9qpPyNJy3Sc3NaSxIN1qA3m2QR+wD5JkCrttsQPZ86o48xW8+7s5k2IkLfjttyi/g8+g
         psLQ==
X-Gm-Message-State: AOAM5318FLwUTjEu5YjgFDWTtJRrZZrnM0sWOVuabQxJGKiPXfkjEHZC
        /o05P3u//JC9Nrr/uyV9ePw=
X-Google-Smtp-Source: ABdhPJw/qE/ac6I/582HmyblUw3dJARRiZ5C8iGiN7CAokxqsV9kIAnmQMwIT5uMXuvibt0EYldZ0g==
X-Received: by 2002:a05:6a00:1709:: with SMTP id h9mr2786398pfc.23.1644299522547;
        Mon, 07 Feb 2022 21:52:02 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7164:d581:d7ee:53bb])
        by smtp.gmail.com with ESMTPSA id gb5sm1273066pjb.16.2022.02.07.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:52:01 -0800 (PST)
Date:   Mon, 7 Feb 2022 21:51:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] Input: mtk-pmic-keys - add support for MT6358
Message-ID: <YgIE/806gDmRJYCn@google.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
 <20220121140323.4080640-4-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121140323.4080640-4-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:03:22PM +0100, Mattijs Korpershoek wrote:
> MT6358 pmic keys behave differently than mt6397 and mt6323: there are
> two interrupts per key: one for press, the other one for release (_r)
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied, thank you.

-- 
Dmitry

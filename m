Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85B48EE95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiANQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiANQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:43:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:43:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id br17so32048055lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-disposition;
        bh=u50us0AD3nwGYBzCMwJX7WF8TLsdut+YHsrfo8CJPWQ=;
        b=a3CJyZ/jLU+cLlc4mE7a17qTVo6dS8r1yJT4nLU2EjLDne0kM8tuyzg8e9wWe8Y1rZ
         3AXxcWkjz0JMQQcUCCR6PJbQDnZAeBNIWcKqImx3Pa5L56hGimc/3ORnnApaoP894PdK
         4rXCMZQJHWmJmNJkolRra+cze7ZgjxSnGA4gjjLJa5m8XCSFDCFE86xBWE8AWmespNMk
         yJyXCtmfidb3+QLyY1CnUdJ3TSngGut+5JFcvtOEeIIE2WFYOVlUAoA6ALWgnZScIXqL
         lsHTm2r9wNTqPUXDkb//zbLZf8sWShuNhg/HxM4Tp7utxuJilgkPmAImhNDMpv635j5G
         PL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version:content-disposition;
        bh=u50us0AD3nwGYBzCMwJX7WF8TLsdut+YHsrfo8CJPWQ=;
        b=eoFIUoJYEqJ0bQSRlBB9/Ax7fvem3cY4HZiNBOaFa3XfgjOWchZjBTVpO1TgAarvH3
         +WiJN0iZqc63YD9RF+WTMllM93Xc27TO37b/f6G2J6+NOH8AH+qOdUGHaDIhmPmpaNdD
         AXMbZxKFXZZuFAwm7qA7kNw5Cb0VWX8CFgOrrubKkqc2ueavWkpmswJPaXVu7x9AiNhL
         mEKVGpIgdCtiKwp36xoM2mc0zRGRRzGVnfE+CDAHNYVJwJFbAdghQbGMYtIDot5B8ksa
         NUl4OerPBZj2SUud0anO70CgLafsmsEAiZ9Zs6PRAmp/v53lFgsOHt2/nyChCZkxeX+0
         1G3g==
X-Gm-Message-State: AOAM531GQJ6FqYzEj3pudAZrNeW3O6sp4a9iviFq/ABH/Ul9JE5sVsrN
        JhdQw0DYAmNkLcajwgtKwNE=
X-Google-Smtp-Source: ABdhPJy8oRBd9adSSDaJ1p5ffaklWXFU0PbvMzO4ZwJ2by8ZODfckkMB6FgQBA1GYupkLKeHr6Vacg==
X-Received: by 2002:a2e:b4b8:: with SMTP id q24mr2950046ljm.482.1642178604185;
        Fri, 14 Jan 2022 08:43:24 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id cf42sm627703lfb.251.2022.01.14.08.43.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Jan 2022 08:43:23 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:49:05 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] ALSA: hda/realtek: fix speakers and micmute on HP 855
Message-ID: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
User-Agent: mtt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rebased and re-tested on the latest sound.git tree.

Alexander Sergeyev (1):
  ALSA: hda/realtek: fix speakers and micmute on HP 855 G8

 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


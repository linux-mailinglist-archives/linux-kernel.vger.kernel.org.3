Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F753C813
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiFCKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiFCKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:02:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E26241;
        Fri,  3 Jun 2022 03:02:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k16so9757761wrg.7;
        Fri, 03 Jun 2022 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sYHeWkVxny/ObhZoM4brVHTU97s0cgwQP8a4JEenA38=;
        b=po39md/xI0LwRWCjM4OfXa3aKeZ37Zlfm6fInusj/f9e8DVo6UJGWpNVG9Vkcu+4Et
         eylZVg2+ExXUBPrhA80RTLuNRfuEz8Wf4kP75oDGPzfHcJcHQadYQrgssxq58jrIGiof
         WKbZmKZ6wTJ86c9WvCxsCjDn6t+dFP9dmYKpYfn9QSJ5xgIs7WrGTBAwvJr76FeBIreB
         E5nBlD/3/1hogCaZpnbijWxzy3gj//kmjqCVaBEgl2dVp0ORv6ldrhzIyV4ApnDyFf0Y
         7Mw4qtrSLTI5rNtvXZ5Jjb3KBFXO9F2MZrJnWwpqU3BYg2IULUAUfNhdAmXkbdQd3Ieo
         FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sYHeWkVxny/ObhZoM4brVHTU97s0cgwQP8a4JEenA38=;
        b=XOoYFBUOgBFfRY+Bqhei3otkDhnpdbhisncJBp8x5ljZ32tM+5tsXn0wanza3azmn5
         y3cU9oynKCD5dDkLFJXe42rqQOrE/ZXDIqPe/Vc50ZS5iD7AadZ5B5m+M1lbIEz0LMZ8
         Xuspxo5DI3kC/fba6pXnjsuQQxxVUWCqOaQsUtmu9PCkyMep0HFan8iNgPyYpMvunmoJ
         U3KQnzZAsy40ozC4/fqEgs/Sc6yD2Lra+E3yBxcfv3J8e1ye5Cy0pUSiHZn0ZpwXrAeP
         gly005UiygmEA6UE65e38ebkJ/kvSuOvNWMKJfoko/KjCVCOWQEofhN7q6PtjoJATQzw
         Rgbg==
X-Gm-Message-State: AOAM531cbcqAK9snJYpsgJE+uEeEydvIYkdF8G/1+wy19gT2eHbh1S3j
        gPucJ/UVrP67enb1RM4H/YU=
X-Google-Smtp-Source: ABdhPJwBpGUch9cmU1s88YRUrOBWW2lMWJYsoinsgV5YwUZzOrPJvX0MoVLlzG8Vz9FVPSJd9ghGTg==
X-Received: by 2002:a5d:6a0e:0:b0:213:1f7f:e1cc with SMTP id m14-20020a5d6a0e000000b002131f7fe1ccmr6255238wru.31.1654250572061;
        Fri, 03 Jun 2022 03:02:52 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003974860e15esm2879639wmf.40.2022.06.03.03.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 03:02:51 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:02:49 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Nick Hawkins <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: mainline build failure due to 6b47441bed49 ("watchdog: hpe-wdt:
 Introduce HPE GXP Watchdog")
Message-ID: <YpncSXSTTyKGprLi@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for "arm allmodconfig"
with the error:
ERROR: modpost: missing MODULE_LICENSE() in drivers/watchdog/gxp-wdt.o
make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1

The file is missing MODULE_LICENSE().


--
Regards
Sudip

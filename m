Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094A59AF85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiHTSQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F117071
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c39so9160796edf.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zxudM2tcPvdpF6lvNkQWPZ2gRI9Z+4KijeRHmXked3o=;
        b=lGuqy5RuA8LlN/SiSPC0Zgm+nIRAWvuxmyWCh+Z7y2RZ4rfhPsIMLB6bAtENbZU69O
         FvRVSaQsFXCsoiPp/aQUN54t2x8DdzgZS2z0a29giaM5xgI6M+m1DYNT02aqmXE7zQhm
         Oqbi3U2igj6+I7yeIQVeZfSE0mj6dC7F9h/dzao0JW/eWWmcXqqgB270gvPDHN+cOef2
         XmT68N9tS77HnK5kgd9bcd1M8eNvlMoEsj30PVvQphg4UfdvifKnSdNGEBsUlPyOa7uj
         nHjJGmKK0OD16DBc6gjJT0EmFKybTvPQzjoU+DsukqBJ6ZfG/qXCJ031vz628yHTSXPG
         EVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zxudM2tcPvdpF6lvNkQWPZ2gRI9Z+4KijeRHmXked3o=;
        b=i4Gk+F3sUFdoMHfjsmommR5DxcgFEleqKe2aS5bbDcJusjLNO/aZP+32mznbyaDG/d
         7ebTxfvITcEnIUKagLPGyRwFWbOkv1Agsl38Ao+SnOXPgXplBh3s960ssmrZAetB09VE
         Uk3lMtXal55qJkw6GfG7lS70JiuLNcAfhMnQiInG+rJLSURPlPGY2bX+NdnHwEmb7joU
         oL6Y2r3ssl+CsJRcmXg8z6K3PvHOAktqZJjE401Cc4k96U7S14KWAayYelD8Q3eKpeE7
         VeUBPn/a2O5RzlEGwPJA0fhtjO/8RYimb15AIqy2FbFiaATJCvdjR9vpRq4DNGiE21Tu
         S+1Q==
X-Gm-Message-State: ACgBeo1GwdZBb6wWOeDMhOn2L7nsyJgYejTKPL7l4uyPpKTKCr5VeNnR
        VDBnXmU0iLkKIQYID3al6HY=
X-Google-Smtp-Source: AA6agR67n8eYzr+YF+2nu35VSIKhyqXQWQDOmBUTahlwivUqUcAFqFT16f42A/fNTIP1avPdfM6zfQ==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr10217794edb.0.1661019396245;
        Sat, 20 Aug 2022 11:16:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/19] staging: r8188eu: migrate os_dep/xmit_linux.c
Date:   Sat, 20 Aug 2022 20:16:04 +0200
Message-Id: <20220820181623.12497-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

This series moves the functions, or their functionality, from
os_dep/xmit_linux.c to the core/* part of the driver and finally
removes os_dep/xmit_linux.c and the xmit_osdep.h header.

Tested on x86_64 with Inter-Tech DMG-02.

Please apply this on top of:
[PATCH] staging: r8188eu: remove rtw_endofpktfile()

Thanks,
Michael

Michael Straube (19):
  staging: r8188eu: make rtw_remainder_len() static
  staging: r8188eu: make rtw_os_xmit_schedule() static
  staging: r8188eu: rename rtw_os_xmit_schedule()
  staging: r8188eu: make rtw_os_xmit_resource_alloc() static
  staging: r8188eu: rename rtw_os_xmit_resource_alloc()
  staging: r8188eu: make rtw_os_xmit_resource_free() static
  staging: r8188eu: rename rtw_os_xmit_resource_free()
  staging: r8188eu: make _rtw_open_pktfile() static
  staging: r8188eu: rename _rtw_open_pktfile()
  staging: r8188eu: make _rtw_pktfile_read() static
  staging: r8188eu: rename _rtw_pktfile_read()
  staging: r8188eu: remove unnecessary initialization to zero
  staging: r8188eu: move struct pkt_file to rtw_xmit.h
  staging: r8188eu: move rtw_os_xmit_complete() to rtw_xmit.c
  staging: r8188eu: rename rtw_os_xmit_complete()
  staging: r8188eu: make rtw_os_pkt_complete() static
  staging: r8188eu: rename rtw_os_pkt_complete()
  staging: r8188eu: remove os_dep/xmit_linux.c
  staging: r8188eu: remove xmit_osdep.h

 drivers/staging/r8188eu/Makefile             |   1 -
 drivers/staging/r8188eu/core/rtw_mlme.c      |  23 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |   1 -
 drivers/staging/r8188eu/core/rtw_xmit.c      | 232 +++++++++++++++++--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |   4 +-
 drivers/staging/r8188eu/include/rtw_xmit.h   |  16 +-
 drivers/staging/r8188eu/include/xmit_osdep.h |  48 ----
 drivers/staging/r8188eu/os_dep/os_intfs.c    |   7 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c    |   1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 226 ------------------
 11 files changed, 251 insertions(+), 310 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h
 delete mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c

-- 
2.37.2


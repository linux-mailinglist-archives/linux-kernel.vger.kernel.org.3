Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB148791B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiAGOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiAGOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:36:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562ACC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:36:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m21so23057090edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NK1daiMXXe0LeZNqPUiALjw7BMBMV4uzHsm9KMsXtg0=;
        b=gfE1VC/xN1Gf+WwqI7G4ljA87mIcGks2r6mp1MlP+xjVIxDGtuEjrT8VZawygxA0rh
         EE0Mkz9zV5n3GODOlvhMZe6cIukDQNolseuER31yKDxUOgYJl2NK+bCcZzgGjclYXw6/
         6d53AV+18lbON7rYp3fKhH3xUbG1qrfuUYDv3reE+UUmTaJuYRCznz8oYgwjlP2rQrlH
         VPe5zKk1UPb8PeamhhrgnkzyjZLZMMc5o5h1bDSmIO2j8JnXR/cTPaInIjtgp4+JHKaT
         0bJB4bsGDnygiHewyLloczEJ01BwWSix00M583WtKv4N9ll0iKGNqjq/hFxrSJkVf93e
         ZJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NK1daiMXXe0LeZNqPUiALjw7BMBMV4uzHsm9KMsXtg0=;
        b=WXhk2rQKt/lG57mzptEya2qnDINSDsbnWOSJXrNCe0YA/a++hqmmV5AaQyolDt3sF3
         QhsIt8M45021EMNXJI5+9oS8x4vlS9BqgT/3OlYqyhM6S7MVQ5OpiPTS8IxDaynA/T9B
         FQuVyhBWVTRwj9CBvqDTdh3o9b4Yy/FMrjvTyS2TuCjelWGgMDo6yJt2ObBoESbigT+K
         s9zxeoLbSqZ4Dfl8PY+MNjzVO7+0+9wZlKlJt6ew6TxX71K1UIuCsaq4GQlaeAaDmUb3
         gM3gijTzfNu1sda//qyZ8OK3/L2SK6je8zhTRqgf9o7984xGyzcuNoTXDe4q5Y4M4du0
         7PEw==
X-Gm-Message-State: AOAM532NyC1oesPDzplFB4xsshr+tcHGOWTFaK/XW+YeB2dDQPIdMjUH
        49IK32o42VrHiJ90vPM94Mw=
X-Google-Smtp-Source: ABdhPJxrCWNxevTx7Tkga8k6Ujuhdr0bSHNVETc57425UiHlwXlQuZl8hByA3zr9KUI1zLMQ4e0EQA==
X-Received: by 2002:a17:906:87c9:: with SMTP id zb9mr2645803ejb.725.1641566190968;
        Fri, 07 Jan 2022 06:36:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id b4sm1445181ejl.206.2022.01.07.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:36:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: move firmware related macros to rtw_fw.h
Date:   Fri,  7 Jan 2022 15:36:14 +0100
Message-Id: <20220107143617.2214-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves firmware related macros from rtl8188e_hal.h to rtw_fw.h.
I missed these when I moved the firmware code into its own file.

Please apply this series on top of the series
"staging: r8188eu: move firmware loading out of the hal layer".

Thanks,
Michael

Michael Straube (3):
  staging: r8188eu: rename _pFwHdr in IS_FW_HEADER_EXIST
  staging: r8188eu: add spaces around & operator in IS_FW_HEADER_EXIST
  staging: r8188eu: move firmware related macros to rtw_fw.h

 drivers/staging/r8188eu/include/rtl8188e_hal.h | 11 -----------
 drivers/staging/r8188eu/include/rtw_fw.h       | 10 +++++++++-
 2 files changed, 9 insertions(+), 12 deletions(-)

-- 
2.34.1


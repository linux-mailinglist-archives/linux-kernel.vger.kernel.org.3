Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1B565545
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiGDM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiGDM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7711A0A;
        Mon,  4 Jul 2022 05:26:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so11480542edb.9;
        Mon, 04 Jul 2022 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqoVCGDCGZDBmrA96lhlLMZTaqVBMBouX+m6wwZdWOE=;
        b=H5YivzCEeuE34uBRZ1K2eXgJvgjMsEE3Bgi2KgX7fu+w3cS5nW349X7mr3neE0B1C/
         Pkzw11eqV/TkHqjmnP75UrBZarZofNwO2vVN1IVj4onUShy/TXV02eoLe41XE+8101NE
         BrZQfpJne04U/ZOUS+n7X4Q3pjfIkMreMoP5LLqXEdypE8QHuJzdUQm6gwvcq+YfRJYs
         UgQo0CQCGol/N+VpOwx3dORZU65EXEkyDYM20ALv7o0OUVNUOjMVhq3ddi11Ymb0WHuz
         /cAUH4YmaYlviApq9gFqmt8oDr6QWUzdgdrUDqu0/FPnY/2UqaTDtP0WK70nbo/6ZYWI
         uG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqoVCGDCGZDBmrA96lhlLMZTaqVBMBouX+m6wwZdWOE=;
        b=MfK5GEJH97DVEHTTsQwyHgrmRz4P6XKPMuEi0U4Qvdcrd22SBIof+2zHXrsZI6BnoX
         MuX0oIM5+QfFmtZuUoH+czaedFvfYdCqgTWlMHNpAcbEwHWtR1/GPLxnPwmqLEICaODh
         npG8th0jSW+KUClKxhfCCBuT8F36mj47Ap5VGAN7ifwmhUz+pQ4yUCNcL/EZzLoOeMFo
         t+03p4qEtbEMnhk7naMSCBXpFmgFQrKkSdfAp22azGQNT0AvF9M9rix/HK6PO5SPXZnw
         kjgZJ5JwLT6QgPkUnN/WcKkAdz9uIVoc7td6nyt+cP3FCyfmbHfNqUC1JSu/sP6GcwOR
         PPZA==
X-Gm-Message-State: AJIora/mVmYV4Gcvhxt+S79I4R+SlI5CV9vOx+1Prh4IrUbYwQK+UIM0
        EshoQ9FW7lV/KMD+cTh9ydA=
X-Google-Smtp-Source: AGRyM1t5l8M3izaIw/C3KP+Yg+kSA8eM3kCKu1yn93LomFTjJFBys4CFyjNAkZtpSjLomPRNbRJ6Ng==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr38628446edx.101.1656937597487;
        Mon, 04 Jul 2022 05:26:37 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:37 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 11/11] docs: zh_TW: align to submitting-drivers removal
Date:   Mon,  4 Jul 2022 14:25:37 +0200
Message-Id: <20220704122537.3407-12-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
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

Adjust the Taiwanese translation to the removal of submitting-drivers in
the English kernel documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../translations/zh_TW/process/5.Posting.rst  |   3 +-
 .../translations/zh_TW/process/howto.rst      |   1 -
 .../translations/zh_TW/process/index.rst      |   1 -
 .../zh_TW/process/submitting-drivers.rst      | 164 ------------------
 4 files changed, 1 insertion(+), 168 deletions(-)
 delete mode 100644 Documentation/translations/zh_TW/process/submitting-drivers.rst

diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index 5578bca403e6..280a8832ecc0 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -22,8 +22,7 @@
 內核開發社區已經發展出一套用於發布補丁的約定和過程；遵循這些約定和過程將使
 參與其中的每個人的生活更加輕鬆。本文檔試圖描述這些約定的部分細節；更多信息
 也可在以下文檔中找到
-:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`，
-:ref:`Documentation/translations/zh_TW/process/submitting-drivers.rst <tw_submittingdrivers>`
+:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 和 :ref:`Documentation/translations/zh_TW/process/submit-checklist.rst <tw_submitchecklist>`。
 
 何時郵寄
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 2043691b92e3..68ae4411285b 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -99,7 +99,6 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     的代碼。
 
   :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
-  :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
 
     這兩份文檔明確描述如何創建和發送補丁，其中包括（但不僅限於)：
        - 郵件內容
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documentation/translations/zh_TW/process/index.rst
index ec7ad14bfd13..c5c59b4fd595 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -43,7 +43,6 @@
 .. toctree::
    :maxdepth: 1
 
-   submitting-drivers
    submit-checklist
    stable-api-nonsense
    stable-kernel-rules
diff --git a/Documentation/translations/zh_TW/process/submitting-drivers.rst b/Documentation/translations/zh_TW/process/submitting-drivers.rst
deleted file mode 100644
index 2fdd742318ba..000000000000
--- a/Documentation/translations/zh_TW/process/submitting-drivers.rst
+++ /dev/null
@@ -1,164 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. _tw_submittingdrivers:
-
-.. include:: ../disclaimer-zh_TW.rst
-
-:Original: :ref:`Documentation/process/submitting-drivers.rst
-           <submittingdrivers>`
-
-如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
-交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
-譯存在問題，請聯繫中文版維護者::
-
-        中文版維護者： 李陽  Li Yang <leoyang.li@nxp.com>
-        中文版翻譯者： 李陽  Li Yang <leoyang.li@nxp.com>
-        中文版校譯者： 陳琦 Maggie Chen <chenqi@beyondsoft.com>
-                       王聰 Wang Cong <xiyou.wangcong@gmail.com>
-                       張巍 Zhang Wei <wezhang@outlook.com>
-                       胡皓文 Hu Haowen <src.res@email.cn>
-
-如何向 Linux 內核提交驅動程序
-=============================
-
-這篇文檔將會解釋如何向不同的內核源碼樹提交設備驅動程序。請注意，如果你感
-興趣的是顯卡驅動程序，你也許應該訪問 XFree86 項目(https://www.xfree86.org/)
-和／或 X.org 項目 (https://x.org)。
-
-另請參閱 Documentation/translations/zh_TW/process/submitting-patches.rst 文檔。
-
-
-分配設備號
-----------
-
-塊設備和字符設備的主設備號與從設備號是由 Linux 命名編號分配權威 LANANA（
-現在是 Torben Mathiasen）負責分配。申請的網址是 https://www.lanana.org/。
-即使不準備提交到主流內核的設備驅動也需要在這裡分配設備號。有關詳細信息，
-請參閱 Documentation/admin-guide/devices.rst。
-
-如果你使用的不是已經分配的設備號，那麼當你提交設備驅動的時候，它將會被強
-制分配一個新的設備號，即便這個設備號和你之前發給客戶的截然不同。
-
-設備驅動的提交對象
-------------------
-
-Linux 2.0:
-	此內核源碼樹不接受新的驅動程序。
-
-Linux 2.2:
-	此內核源碼樹不接受新的驅動程序。
-
-Linux 2.4:
-	如果所屬的代碼領域在內核的 MAINTAINERS 文件中列有一個總維護者，
-	那麼請將驅動程序提交給他。如果此維護者沒有回應或者你找不到恰當的
-	維護者，那麼請聯繫 Willy Tarreau <w@1wt.eu>。
-
-Linux 2.6:
-	除了遵循和 2.4 版內核同樣的規則外，你還需要在 linux-kernel 郵件
-	列表上跟蹤最新的 API 變化。向 Linux 2.6 內核提交驅動的頂級聯繫人
-	是 Andrew Morton <akpm@linux-foundation.org>。
-
-決定設備驅動能否被接受的條件
-----------------------------
-
-許可：		代碼必須使用 GNU 通用公開許可證 (GPL) 提交給 Linux，但是
-		我們並不要求 GPL 是唯一的許可。你或許會希望同時使用多種
-		許可證發布，如果希望驅動程序可以被其他開源社區（比如BSD）
-		使用。請參考 include/linux/module.h 文件中所列出的可被
-		接受共存的許可。
-
-版權：		版權所有者必須同意使用 GPL 許可。最好提交者和版權所有者
-		是相同個人或實體。否則，必需列出授權使用 GPL 的版權所有
-		人或實體，以備驗證之需。
-
-接口：		如果你的驅動程序使用現成的接口並且和其他同類的驅動程序行
-		爲相似，而不是去發明無謂的新接口，那麼它將會更容易被接受。
-		如果你需要一個 Linux 和 NT 的通用驅動接口，那麼請在用
-		戶空間實現它。
-
-代碼：		請使用 Documentation/process/coding-style.rst 中所描述的 Linux 代碼風
-		格。如果你的某些代碼段（例如那些與 Windows 驅動程序包共
-		享的代碼段）需要使用其他格式，而你卻只希望維護一份代碼，
-		那麼請將它們很好地區分出來，並且註明原因。
-
-可移植性：	請注意，指針並不永遠是 32 位的，不是所有的計算機都使用小
-		尾模式 (little endian) 存儲數據，不是所有的人都擁有浮點
-		單元，不要隨便在你的驅動程序里嵌入 x86 彙編指令。只能在
-		x86 上運行的驅動程序一般是不受歡迎的。雖然你可能只有 x86
-		硬體，很難測試驅動程序在其他平台上是否可用，但是確保代碼
-		可以被輕鬆地移植卻是很簡單的。
-
-清晰度：	做到所有人都能修補這個驅動程序將會很有好處，因爲這樣你將
-		會直接收到修復的補丁而不是 bug 報告。如果你提交一個試圖
-		隱藏硬體工作機理的驅動程序，那麼它將會被扔進廢紙簍。
-
-電源管理：	因爲 Linux 正在被很多行動裝置和桌面系統使用，所以你的驅
-		動程序也很有可能被使用在這些設備上。它應該支持最基本的電
-		源管理，即在需要的情況下實現系統級休眠和喚醒要用到的
-		.suspend 和 .resume 函數。你應該檢查你的驅動程序是否能正
-		確地處理休眠與喚醒，如果實在無法確認，請至少把 .suspend
-		函數定義成返回 -ENOSYS（功能未實現）錯誤。你還應該嘗試確
-		保你的驅動在什麼都不乾的情況下將耗電降到最低。要獲得驅動
-		程序測試的指導，請參閱
-		Documentation/power/drivers-testing.rst。有關驅動程序電
-		源管理問題相對全面的概述，請參閱
-		Documentation/driver-api/pm/devices.rst。
-
-管理：		如果一個驅動程序的作者還在進行有效的維護，那麼通常除了那
-		些明顯正確且不需要任何檢查的補丁以外，其他所有的補丁都會
-		被轉發給作者。如果你希望成爲驅動程序的聯繫人和更新者，最
-		好在代碼注釋中寫明並且在 MAINTAINERS 文件中加入這個驅動
-		程序的條目。
-
-不影響設備驅動能否被接受的條件
-------------------------------
-
-供應商：	由硬體供應商來維護驅動程序通常是一件好事。不過，如果源碼
-		樹里已經有其他人提供了可穩定工作的驅動程序，那麼請不要期
-		望「我是供應商」會成爲內核改用你的驅動程序的理由。理想的情
-		況是：供應商與現有驅動程序的作者合作，構建一個統一完美的
-		驅動程序。
-
-作者：		驅動程序是由大的 Linux 公司研發還是由你個人編寫，並不影
-		響其是否能被內核接受。沒有人對內核源碼樹享有特權。只要你
-		充分了解內核社區，你就會發現這一點。
-
-
-資源列表
---------
-
-Linux 內核主源碼樹：
-	ftp.??.kernel.org:/pub/linux/kernel/...
-	?? == 你的國家代碼，例如 "cn"、"us"、"uk"、"fr" 等等
-
-Linux 內核郵件列表：
-	linux-kernel@vger.kernel.org
-	[可通過向majordomo@vger.kernel.org發郵件來訂閱]
-
-Linux 設備驅動程序，第三版（探討 2.6.10 版內核）：
-	https://lwn.net/Kernel/LDD3/ （免費版）
-
-LWN.net:
-	每周內核開發活動摘要 - https://lwn.net/
-
-	2.6 版中 API 的變更：
-
-		https://lwn.net/Articles/2.6-kernel-api/
-
-	將舊版內核的驅動程序移植到 2.6 版：
-
-		https://lwn.net/Articles/driver-porting/
-
-內核新手(KernelNewbies):
-	爲新的內核開發者提供文檔和幫助
-	https://kernelnewbies.org/
-
-Linux USB項目：
-	http://www.linux-usb.org/
-
-寫內核驅動的「不要」（Arjan van de Ven著）:
-	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
-
-內核清潔工 (Kernel Janitor):
-	https://kernelnewbies.org/KernelJanitors
-
-- 
2.17.1


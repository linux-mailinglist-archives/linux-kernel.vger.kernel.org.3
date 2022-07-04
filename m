Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE026565543
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiGDM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiGDM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D27DED2;
        Mon,  4 Jul 2022 05:26:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x10so4152990edd.13;
        Mon, 04 Jul 2022 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3e18M7TEQn0eLwjSdz0vhOa93LeHIVW/hOah37kT2Y=;
        b=QOg3XmrLiUPfs5Dgm3y22z+GWCXllcdV4tknbzIP6xK1NCbCqtVNEK9QAUmHsceBak
         r3tpYDnaHLu2bBaL6Ee7hG4IZKP5gv60JuuaMWLS7sujB02c6ZPlqvUJzBZWKDgp1/Zl
         KCwSIWH1vEeIqT8oeTZAxtt3V2IRR0c/LFTk6H9hI4EkI8exlkqIVvqlbUBnQIgX1PHQ
         Vp57JUDHOieBEXeb4sl7fWnYO/OBuja4b1kp3tB4rb3NKNOC+AJWmBP4X7JZAOStynQb
         5h55/6BCxcc/SUVpNEKpP/f7EsJ9rVbGHiHSBlr9kdJyuQQPj/10sTxWeypcgHO09bW4
         vgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3e18M7TEQn0eLwjSdz0vhOa93LeHIVW/hOah37kT2Y=;
        b=GXlBM1F2897QVu+a/rl0HCtaLclIjABLqxck3Pf42711m2wqr/giQIZfEAI0z2ZIS+
         VtmqwCkyEU19cUpVe2yNHi8umBwCIYJxB8LuwIBxaZc5ppMqPhBiJgavcgdMlontX9UX
         EiprWmVH64U/iMxtFKmkZK39pVZ0vCeDOUFWoB79bgTqeb4qkd8cwKYvCSzAoCpwDLa6
         c3Pfsz4mlBvYCi86yd9Orh4kRGH4ec6JY/LFfQfgUacuYPb6azW2ExB2o5xBlEgen50/
         jho82nXlXDhiGsl0zvfgLudPkBHXQS9dX+ffyftpLO6za/51XVe/CMb/DFQnBNZNccx1
         Tv1w==
X-Gm-Message-State: AJIora+8M5SkSj1oXdqWxHo42oNnTHEF3YlijwVTNBXQqFuvXoqrNvxY
        mD2fE4FQJCX8s+KG5RJxOko=
X-Google-Smtp-Source: AGRyM1vZK2sDKE8y7Exu0E43Cq75TFOqPnDcjLhIpl698Q5soueZc27nSrvNSiqWdR178fq+O24NxA==
X-Received: by 2002:a05:6402:520c:b0:435:af40:8dc6 with SMTP id s12-20020a056402520c00b00435af408dc6mr39643028edd.343.1656937595903;
        Mon, 04 Jul 2022 05:26:35 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:35 -0700 (PDT)
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
Subject: [PATCH 10/11] docs: zh_CN: align to submitting-drivers removal
Date:   Mon,  4 Jul 2022 14:25:36 +0200
Message-Id: <20220704122537.3407-11-lukas.bulwahn@gmail.com>
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

Adjust the Chinese translation to the removal of submitting-drivers in the
English kernel documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../zh_CN/kernel-hacking/hacking.rst          |   3 +-
 .../translations/zh_CN/process/5.Posting.rst  |   3 +-
 .../translations/zh_CN/process/howto.rst      |   1 -
 .../translations/zh_CN/process/index.rst      |   1 -
 .../zh_CN/process/submitting-drivers.rst      | 160 ------------------
 5 files changed, 2 insertions(+), 166 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/process/submitting-drivers.rst

diff --git a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
index f2bc154c5bcc..2c85ddfbfd3a 100644
--- a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
+++ b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
@@ -633,8 +633,7 @@ C++
    文件（无论如何你的名字都应该在源文件的顶部）。维护人员意味着您希望在对
    子系统进行更改时得到询问，并了解缺陷；这意味着对某部分代码做出更多承诺。
 
--  最后，别忘记去阅读 Documentation/process/submitting-patches.rst ，
-   也许还有 Documentation/process/submitting-drivers.rst 。
+-  最后，别忘记去阅读 Documentation/process/submitting-patches.rst。
 
 Kernel 仙女棒
 ===============
diff --git a/Documentation/translations/zh_CN/process/5.Posting.rst b/Documentation/translations/zh_CN/process/5.Posting.rst
index 4ee7de13f373..6a469e1c7deb 100644
--- a/Documentation/translations/zh_CN/process/5.Posting.rst
+++ b/Documentation/translations/zh_CN/process/5.Posting.rst
@@ -19,8 +19,7 @@
 内核开发社区已经发展出一套用于发布补丁的约定和过程；遵循这些约定和过程将使
 参与其中的每个人的生活更加轻松。本文档试图描述这些约定的部分细节；更多信息
 也可在以下文档中找到
-:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`，
-:ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 和 :ref:`Documentation/translations/zh_CN/process/submit-checklist.rst <cn_submitchecklist>`。
 
 何时寄送
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 1334cdb32a3c..1455190dc087 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -96,7 +96,6 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     的代码。
 
   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
-  :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
 
     这两份文档明确描述如何创建和发送补丁，其中包括（但不仅限于)：
        - 邮件内容
diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index 39e9c88fbaa6..a683dbea0c83 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -40,7 +40,6 @@
 .. toctree::
    :maxdepth: 1
 
-   submitting-drivers
    submit-checklist
    stable-api-nonsense
    stable-kernel-rules
diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
deleted file mode 100644
index 98341e7cd812..000000000000
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ /dev/null
@@ -1,160 +0,0 @@
-﻿.. _cn_submittingdrivers:
-
-.. include:: ../disclaimer-zh_CN.rst
-
-:Original: :ref:`Documentation/process/submitting-drivers.rst
-           <submittingdrivers>`
-
-如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
-交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者::
-
-        中文版维护者： 李阳  Li Yang <leoyang.li@nxp.com>
-        中文版翻译者： 李阳  Li Yang <leoyang.li@nxp.com>
-        中文版校译者： 陈琦 Maggie Chen <chenqi@beyondsoft.com>
-                       王聪 Wang Cong <xiyou.wangcong@gmail.com>
-                       张巍 Zhang Wei <wezhang@outlook.com>
-
-如何向 Linux 内核提交驱动程序
-=============================
-
-这篇文档将会解释如何向不同的内核源码树提交设备驱动程序。请注意，如果你感
-兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(https://www.xfree86.org/)
-和／或 X.org 项目 (https://x.org)。
-
-另请参阅 Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
-
-
-分配设备号
-----------
-
-块设备和字符设备的主设备号与从设备号是由 Linux 命名编号分配权威 LANANA（
-现在是 Torben Mathiasen）负责分配。申请的网址是 https://www.lanana.org/。
-即使不准备提交到主流内核的设备驱动也需要在这里分配设备号。有关详细信息，
-请参阅 Documentation/admin-guide/devices.rst。
-
-如果你使用的不是已经分配的设备号，那么当你提交设备驱动的时候，它将会被强
-制分配一个新的设备号，即便这个设备号和你之前发给客户的截然不同。
-
-设备驱动的提交对象
-------------------
-
-Linux 2.0:
-	此内核源码树不接受新的驱动程序。
-
-Linux 2.2:
-	此内核源码树不接受新的驱动程序。
-
-Linux 2.4:
-	如果所属的代码领域在内核的 MAINTAINERS 文件中列有一个总维护者，
-	那么请将驱动程序提交给他。如果此维护者没有回应或者你找不到恰当的
-	维护者，那么请联系 Willy Tarreau <w@1wt.eu>。
-
-Linux 2.6:
-	除了遵循和 2.4 版内核同样的规则外，你还需要在 linux-kernel 邮件
-	列表上跟踪最新的 API 变化。向 Linux 2.6 内核提交驱动的顶级联系人
-	是 Andrew Morton <akpm@linux-foundation.org>。
-
-决定设备驱动能否被接受的条件
-----------------------------
-
-许可：		代码必须使用 GNU 通用公开许可证 (GPL) 提交给 Linux，但是
-		我们并不要求 GPL 是唯一的许可。你或许会希望同时使用多种
-		许可证发布，如果希望驱动程序可以被其他开源社区（比如BSD）
-		使用。请参考 include/linux/module.h 文件中所列出的可被
-		接受共存的许可。
-
-版权：		版权所有者必须同意使用 GPL 许可。最好提交者和版权所有者
-		是相同个人或实体。否则，必需列出授权使用 GPL 的版权所有
-		人或实体，以备验证之需。
-
-接口：		如果你的驱动程序使用现成的接口并且和其他同类的驱动程序行
-		为相似，而不是去发明无谓的新接口，那么它将会更容易被接受。
-		如果你需要一个 Linux 和 NT 的通用驱动接口，那么请在用
-		户空间实现它。
-
-代码：		请使用 Documentation/process/coding-style.rst 中所描述的 Linux 代码风
-		格。如果你的某些代码段（例如那些与 Windows 驱动程序包共
-		享的代码段）需要使用其他格式，而你却只希望维护一份代码，
-		那么请将它们很好地区分出来，并且注明原因。
-
-可移植性：	请注意，指针并不永远是 32 位的，不是所有的计算机都使用小
-		尾模式 (little endian) 存储数据，不是所有的人都拥有浮点
-		单元，不要随便在你的驱动程序里嵌入 x86 汇编指令。只能在
-		x86 上运行的驱动程序一般是不受欢迎的。虽然你可能只有 x86
-		硬件，很难测试驱动程序在其他平台上是否可用，但是确保代码
-		可以被轻松地移植却是很简单的。
-
-清晰度：	做到所有人都能修补这个驱动程序将会很有好处，因为这样你将
-		会直接收到修复的补丁而不是 bug 报告。如果你提交一个试图
-		隐藏硬件工作机理的驱动程序，那么它将会被扔进废纸篓。
-
-电源管理：	因为 Linux 正在被很多移动设备和桌面系统使用，所以你的驱
-		动程序也很有可能被使用在这些设备上。它应该支持最基本的电
-		源管理，即在需要的情况下实现系统级休眠和唤醒要用到的
-		.suspend 和 .resume 函数。你应该检查你的驱动程序是否能正
-		确地处理休眠与唤醒，如果实在无法确认，请至少把 .suspend
-		函数定义成返回 -ENOSYS（功能未实现）错误。你还应该尝试确
-		保你的驱动在什么都不干的情况下将耗电降到最低。要获得驱动
-		程序测试的指导，请参阅
-		Documentation/power/drivers-testing.rst。有关驱动程序电
-		源管理问题相对全面的概述，请参阅
-		Documentation/driver-api/pm/devices.rst。
-
-管理：		如果一个驱动程序的作者还在进行有效的维护，那么通常除了那
-		些明显正确且不需要任何检查的补丁以外，其他所有的补丁都会
-		被转发给作者。如果你希望成为驱动程序的联系人和更新者，最
-		好在代码注释中写明并且在 MAINTAINERS 文件中加入这个驱动
-		程序的条目。
-
-不影响设备驱动能否被接受的条件
-------------------------------
-
-供应商：	由硬件供应商来维护驱动程序通常是一件好事。不过，如果源码
-		树里已经有其他人提供了可稳定工作的驱动程序，那么请不要期
-		望“我是供应商”会成为内核改用你的驱动程序的理由。理想的情
-		况是：供应商与现有驱动程序的作者合作，构建一个统一完美的
-		驱动程序。
-
-作者：		驱动程序是由大的 Linux 公司研发还是由你个人编写，并不影
-		响其是否能被内核接受。没有人对内核源码树享有特权。只要你
-		充分了解内核社区，你就会发现这一点。
-
-
-资源列表
---------
-
-Linux 内核主源码树：
-	ftp.??.kernel.org:/pub/linux/kernel/...
-	?? == 你的国家代码，例如 "cn"、"us"、"uk"、"fr" 等等
-
-Linux 内核邮件列表：
-	linux-kernel@vger.kernel.org
-	[可通过向majordomo@vger.kernel.org发邮件来订阅]
-
-Linux 设备驱动程序，第三版（探讨 2.6.10 版内核）：
-	https://lwn.net/Kernel/LDD3/ （免费版）
-
-LWN.net:
-	每周内核开发活动摘要 - https://lwn.net/
-
-	2.6 版中 API 的变更：
-
-		https://lwn.net/Articles/2.6-kernel-api/
-
-	将旧版内核的驱动程序移植到 2.6 版：
-
-		https://lwn.net/Articles/driver-porting/
-
-内核新手(KernelNewbies):
-	为新的内核开发者提供文档和帮助
-	https://kernelnewbies.org/
-
-Linux USB项目：
-	http://www.linux-usb.org/
-
-写内核驱动的“不要”（Arjan van de Ven著）:
-	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
-
-内核清洁工 (Kernel Janitor):
-	https://kernelnewbies.org/KernelJanitors
-- 
2.17.1


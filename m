Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DD48A345
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiAJW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbiAJW4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:56:33 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF376C06173F;
        Mon, 10 Jan 2022 14:56:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id r6so16476027qvr.13;
        Mon, 10 Jan 2022 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSb9Rtzc2rB0X2se1FFsZb5B4yfRP14341OrWlQXomQ=;
        b=OdGvmkGGNbdQ+7HDG9YE2CIMUSdyJEcdNEWU1Qg/YW72tWbghWJwC4kJxTDVJOZTko
         myrVcp1PkD2H7duj412zxBSgxtb4PKIwwdMxGsEnk0FQ2YqKmsGdEoNsh9JWBRh8pzU+
         hj+9bMH+VUOj5zTyaxaTygcSlYjmCistx7x6ScmvPpM8ybYQn2qvfYBIRO7lXVQv0Fgx
         I+1cGJ7zgo0E9C3ALtUyEyxpzZIVumtqfOS2QNMjr9DViADa4h6+GQfH3eRp80M4YxH1
         J/5LNzC7DqNIaWXne+Rs92hSjANFW2eaJ4zGzUINsg1C3x5lBOcF+jn8RtgVYfVd8Mh+
         VA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSb9Rtzc2rB0X2se1FFsZb5B4yfRP14341OrWlQXomQ=;
        b=qdXgAlp7YOmeXm7rXxDkMwb3nNNuobipQxuL27/zU/nVWTOt0ASt3/MAY5bfE2bBvm
         WgFUHbJ+9nZ0TJnXtaKE+lb9Vg5cTRoejNq/OEzP/cZgMrK2kpfiSKLOmBMFCAeI0XpT
         O1moZQyJTtpqPjx0aGFbE8IlWq6l30elM/J68ZllxX92rS+E3NMkaqAZdz4COCf7fb5l
         KOCx2ur2a70nJB1alUoAkdGaweAl6sh3P4bsGQJ8XOg/SBjk/TwaGH3Dc3cirKZmAZzN
         srvf+vH3Z6eDWykhNg47TPilWQNjyUO586aib7mr8QEre9BRJXuURlc5yXOXHlyh4cDn
         XMsQ==
X-Gm-Message-State: AOAM533PYdCYIqEHnROWi3yPI/Te2kXzB4wkc0eWYCM66kIupnnOEyV6
        uBkg5sRe6iORAt2X4NS49X9IxvaJi/jreA==
X-Google-Smtp-Source: ABdhPJzVzXivA5M1cm0jQCOYlIS53sG4ufqiPdFzL5n4OOZotC7csAXEZ/KDOxEd0oOfUzihwZ4s8A==
X-Received: by 2002:ad4:5ec7:: with SMTP id jm7mr1539554qvb.123.1641855391882;
        Mon, 10 Jan 2022 14:56:31 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id w12sm986617qtj.64.2022.01.10.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:56:31 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v12 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Mon, 10 Jan 2022 17:56:21 -0500
Message-Id: <20220110225623.2786104-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110225623.2786104-1-gsomlo@gmail.com>
References: <20220110225623.2786104-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list
of files maintained under LiteX.

Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
the LiteETH driver, and Gabriel is currently curating the LiteX
out-of-tree device drivers as they are tested and prepared for
upstream submission, having also co-authored a number of them.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Acked-by: Mateusz Holenko <mholenko@antmicro.com>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a439c9d486fa..945cde7936b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11040,12 +11040,17 @@ F:	lib/list-test.c
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
+M:	Gabriel Somlo <gsomlo@gmail.com>
+M:	Joel Stanley <joel@jms.id.au>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	arch/openrisc/boot/dts/or1klitex.dts
-F:	drivers/soc/litex/litex_soc_ctrl.c
-F:	drivers/tty/serial/liteuart.c
 F:	include/linux/litex.h
+F:	drivers/tty/serial/liteuart.c
+F:	drivers/soc/litex/*
+F:	drivers/net/ethernet/litex/*
+F:	drivers/mmc/host/litex_mmc.c
+N:	litex
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.31.1


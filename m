Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1917B52820F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiEPK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241400AbiEPK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D139120B6;
        Mon, 16 May 2022 03:27:32 -0700 (PDT)
Message-ID: <20220516102615.766987817@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z4uxJ2Fe9V1FkV5qNjPZemnSQMhnfhGb2cwBVgOV5X8=;
        b=1UUFlMH9zhh/CYxEsMdVlAEz3INtYFSkTJlyFO/l/J50abJ5fs3Li2h5jqBSDjJ2BVagLS
        ZTGi+XcTR+oNOMMzr5KnL4T/+RRtgWt0dLHYix34gqn3T4ECw89TI18m99cE+kU/gyA223
        OLaxNfiI+bGpI90Xr0EgVRFhscH5mYX0rZBnFzakzcrdy2UdUdtN1CFooZnkjVeoe5zmx3
        bux2dARCYBl8NZwrOLAHq5iMVyPJTS6vbWDSZRC1GfYdc4kURMeK3+gcBdjhVIhM31CG9s
        waZTYodZVCjvhcNRkG0QIU3c3cAeZwtHyi874yynaAgMS7zxEHY2sVvEDGunKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z4uxJ2Fe9V1FkV5qNjPZemnSQMhnfhGb2cwBVgOV5X8=;
        b=X8P0/sjKL6dy6xhzTSBqN0JrFYnGyhWnNtpu7TOiVhxkHzePqc/tf6a6T8izQR8JT1CsfY
        Uk+HarZljk/TyfCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 6/9] scripts/spdxcheck: Exclude config directories
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:30 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel configuration files like default configs are machine generated and
pretty useless outside of the kernel context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxexclude |    5 +++++
 1 file changed, 5 insertions(+)

--- a/scripts/spdxexclude
+++ b/scripts/spdxexclude
@@ -6,3 +6,8 @@
 # create lots of noise for no value
 LICENSES/
 license-rules.rst
+
+# Ignore config files and snippets. The majority is generated
+# by the Kconfig tools
+kernel/configs/
+arch/*/configs/


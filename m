Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0457D88E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiGVCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiGVCYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2398202
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:41 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 71F1D3F11D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456680;
        bh=rPPCOknk12Lnh3nWhsdYWqa1mH1t/OQEcqVOb72oZWk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=n2BBS9Lhy+oQ9gw9IAEVwHeDdbyuL5KgTNtHCNueFiC/4CEmDCNmAeRl3XMqDYVNS
         6ZGvTcafLQXAgthuR2whtME5VxeQZPLeDu6l4Dtcgwx4oQuJ6GD3r2iMzD9/I824m6
         +vAaQ6Ic8VLqWlomWqlae4JRPTAKBcqRLPzKqcPfq+5T17uQyJQUuOhGlvyxo9yLsH
         PjH+Rr7GCtfocNEOkR87C9aowXyWYgHGYAh9TThKDGGNcX4JQZETPWwkxPLdNAU4iI
         5xkM3jiHW0InNT8xo0UeRPeMtjzi887pl1bgYK/QInJDY4YYohDTP4mBHrJ+jLH099
         n9r6HaoLF5+iA==
Received: by mail-oi1-f198.google.com with SMTP id r69-20020acaa848000000b0033a6ad03126so1686584oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPPCOknk12Lnh3nWhsdYWqa1mH1t/OQEcqVOb72oZWk=;
        b=ksSWx1MrFi3zP/AOuekVnOMI+Nu0pfcITrO1O8TbNiAi2fhiUHYKWFBkjyowiRitCd
         33CUGPAo9vlB2O6y/7Vn97ZrMu0a8yw3G6e2QQ+9w+ul7n/Hl+TpiwExoVIR0l6qsVkl
         THxU4W0xauSBuq/E4o9n96Tdu3lJhI4WkIfkYBD4OzzfElr0OHUSvU3xjxLHehHx8c/7
         mnKt2YKqAdJ1wUwlN5Pcsey5mOKSnQaCDOMDNcgKHWjRGsAj89r0tsKQWxBjYUmLKEkh
         HW6Svz/pKtpV2Y9loe4LZJXs/N8zfXk3fKhCRVpZTOaQaJru+X/aHsmKMTEFiQ0RH8W3
         hjWQ==
X-Gm-Message-State: AJIora8DxnOF60Qnpf/WcYZ+Bap3mqbhL+Lc5aMWvcceE0Lh874eYj0p
        UrMnmIhDnHGNSBM0ys5/f+xwL2O57IGCbINkcIJLwHL/4MhLPOnDPhdvE8KcHi6Tvvw5PYkwm/Z
        OnfYdnJ/3JV6VteJBDG36k2wejTCZpjR8UDDdJiGfYA==
X-Received: by 2002:a05:6808:d52:b0:339:c88b:8100 with SMTP id w18-20020a0568080d5200b00339c88b8100mr5817227oik.93.1658456679126;
        Thu, 21 Jul 2022 19:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shUKvZ85RWsVY2FWznWPtQPVSjurfGAiTl4rOQmkm6bAI1hnYtfZhQRHhT4FIYWpHeOcMWbw==
X-Received: by 2002:a05:6808:d52:b0:339:c88b:8100 with SMTP id w18-20020a0568080d5200b00339c88b8100mr5817215oik.93.1658456678903;
        Thu, 21 Jul 2022 19:24:38 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:38 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 5/6] netfilter: conntrack: use MODULE_SYSCTL_TABLE
Date:   Thu, 21 Jul 2022 23:24:15 -0300
Message-Id: <20220722022416.137548-6-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's take nf_conntrack as an (actually helpful) example and exerciser,
as it has many sysctl entries, and other module aliases already.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 net/netfilter/nf_conntrack_standalone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 05895878610c..2da628f054cf 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -980,6 +980,8 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 	{}
 };
 
+MODULE_SYSCTL_TABLE(nf_ct_sysctl_table);
+
 static struct ctl_table nf_ct_netfilter_table[] = {
 	{
 		.procname	= "nf_conntrack_max",
@@ -991,6 +993,8 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 	{ }
 };
 
+/* MODULE_SYSCTL_TABLE(nf_ct_sysctl_table) already includes nf_conntrack_max. */
+
 static void nf_conntrack_standalone_init_tcp_sysctl(struct net *net,
 						    struct ctl_table *table)
 {
-- 
2.25.1


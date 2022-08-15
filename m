Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBB592767
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiHOBUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:20:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C112615
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:20:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7E4203200684;
        Sun, 14 Aug 2022 21:19:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 21:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660526398; x=
        1660612798; bh=7eNWv8H3cRZSsU00RghQ7a2wiThZ5kp5PdGbBLn5/OU=; b=m
        2P/WzLALUOD1pq1u7gyVNO2eopnlkRiiOD870cBwYN8XFuULMQ892p00VCU8IvhO
        PCAmReJVCF/YW/LckaDeSZLW2ZZrDUQ3QYJiwhNIexBbvMzKl5qijKHaOJPtXrGU
        LxmnouMepKO031DcwvWnFozMsPItokkFk8tBIdd76t/kOaKGg6dxhCw1WQmMUzLd
        zsreEhrgxT+FMVAHJWx0EX1fgWEsPYSnY8UHmunoLb5pXrcjS/IP5AFPyT74tCY1
        YzizdyWZbEfd5esIjTV/UtkLqW5dBnI59+vAY8gyz+0mHCTboc5WxXWt/nKGFxh/
        bsURNYP1zsflMqi+5k2Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660526398; x=
        1660612798; bh=7eNWv8H3cRZSsU00RghQ7a2wiThZ5kp5PdGbBLn5/OU=; b=Q
        xz8jhjvh4VqpANUsCh9ShLP4lwJv6puMM4dbqI/yFwsqRPJJuHvY7Bz01naxQ/j4
        Jvq1fX6WpB/ve0ifGv2XyEQnNRcstpKWnZmL7BcAVaqStUETSZvHRxxpWOkEaTES
        7cx3x5FT3i9Xsnq6+GnNVgwqXiKXIeaZSUvpgGpdhH6OsoGkURbSIifFVPKcBvWX
        yCjTnnxQ6NRoPHY9zjaiO2tXQbqf6sZ6rGxJfTIW3duQNF65mRkNmxjkWW8YfmM6
        xbWjcUHAJSDvX+cnPlqBIZ5bGZjfAKhz7cuZv2E6mtA5GOnI/BucAk+NF75UT71n
        I/FtI6gYkujkXtVSG/Vlg==
X-ME-Sender: <xms:PZ_5YoUMZEQG4J6RK9yVWJVcaaFCvK05yAP2PtS0FY39zjMYIP1v0Q>
    <xme:PZ_5YsnuaipqaEpc2A96xnL9uuA6K3Jy_cEvu3RbweJScpGdWFW129aZ6e36MLKkw
    GirSHWcwBIvSFQ9awM>
X-ME-Received: <xmr:PZ_5YsaZvIjor6UQae37rnVotY4_hGgv7g_JEZg0qfCIzzXbi0neRxdHvDRUbwPXE39OAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepgfejieekffeffeevudfgtdekvdfhtddtieef
    vedtheeggfejffellefggffgvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:PZ_5YnXJ4GXsnrNAAbkyzkGwaj3g5i-u-SD_S4jUDYi_dglgIpPcfg>
    <xmx:PZ_5Yimp1L8Nhyi4NoalWfSlcGWKUhaSpJrvHFY3odHS7WSOr_Ojrw>
    <xmx:PZ_5Ysd4Ob6GNyeGVK0me4pfcsVIYiZslU7r9H5VU1IE_y8KvU1W0g>
    <xmx:Pp_5YkiQ1yorFop6PqRefYPRK6wVKc5GbsauweZXIlebfi1yX37SJA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 21:19:57 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 47CE6104A60; Mon, 15 Aug 2022 04:23:00 +0300 (+03)
Date:   Mon, 15 Aug 2022 04:23:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc1
Message-ID: <20220815012300.hiz5pd3nynrehkhm@box.shutemov.name>
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same
function") breaks build for me (CONFIG_MODULE=n):

  CC      kernel/trace/ftrace.o
kernel/trace/ftrace.c:3149:1: error: ‘ops_references_rec’ defined but not used [-Werror=unused-function]
 3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
      | ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The fix I used locally:

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..90fa3ceeaeeb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3138,19 +3138,6 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
 	return true;
 }

-/*
- * Check if the current ops references the record.
- *
- * If the ops traces all functions, then it was already accounted for.
- * If the ops does not trace the current record function, skip it.
- * If the ops ignores the function via notrace filter, skip it.
- */
-static bool
-ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
-{
-	return ops_references_ip(ops, rec->ip);
-}
-
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 {
 	bool init_nop = ftrace_need_init_nop();
@@ -6818,6 +6805,19 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,

 static LIST_HEAD(ftrace_mod_maps);

+/*
+ * Check if the current ops references the record.
+ *
+ * If the ops traces all functions, then it was already accounted for.
+ * If the ops does not trace the current record function, skip it.
+ * If the ops ignores the function via notrace filter, skip it.
+ */
+static bool
+ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
+{
+	return ops_references_ip(ops, rec->ip);
+}
+
 static int referenced_filters(struct dyn_ftrace *rec)
 {
 	struct ftrace_ops *ops;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

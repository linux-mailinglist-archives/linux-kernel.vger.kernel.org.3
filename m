Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E24FDDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiDLLeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiDLLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:32:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0174845
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hd4Qmn7eKBTRdotqi16+9FH/NkVNLpVNHv3B9bf+8Dc=; b=TQwr2GedYiQ4rt506PgfxlMauE
        OJBMUQlAy9Gub6AVhDq9Lv620Gf/kx10Ugaz1XF7bXRci9L/oovh9xY2yLlNfm4SxVTar+TIYJ2UT
        M7xjbd3h8vu83uXHNYMqG8yNgtSAGis1yyjw6inIFEWS+MI42AteDltw1s03eP9m/ntALe7DQCGgU
        nfYr05MjbxIpdsPcVL3d9Cx95wCy4ZSA4qh7d6Ih+VUfTQ0eRC8/nEvsRQmMtYsOicgwyzZqc/JOe
        2XvZgblxGLTbM5b6zEPMpeTjPw2n2ajz115K+KpRI4LYytAB+lA0SCliR2QPdqCBqVjr3DpGheXqM
        X07KCH7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neDV8-00DDYi-W2; Tue, 12 Apr 2022 10:11:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B834300250;
        Tue, 12 Apr 2022 12:11:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ADC32DB89DD0; Tue, 12 Apr 2022 12:11:58 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:11:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 1/2] x86/unwind/orc: recheck address range after stack
 info was updated
Message-ID: <YlVQboACrT5QqbJQ@hirez.programming.kicks-ass.net>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Also, guys, do we want something like so?

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..cb5fcb2a9cef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14220,6 +14220,7 @@ M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
 F:	include/linux/objtool.h
+F:	arch/x86/kernel/unwind*
 
 OCELOT ETHERNET SWITCH DRIVER
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F0258A8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiHEJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiHEJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:42:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5815728
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:42:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 546FD2109A;
        Fri,  5 Aug 2022 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659692528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KSNjVUG6R4YnRfpCIx6Z0AzxajKicByex9Au7ZxKnk=;
        b=HrueHj64QgzXnZ4AoZexf5pOy56rfAdrH6U1q6Wzz/CroDW6TDAu+EfLGZpnA5O7smBDxD
        VezJuqNnRUoYPfw/KAeKvh9GLEGNwbIfEj/4AHS5AGXrfMmNRb78OKlhAiRm5P0R8qj5SC
        siaIrBfuPCOkeC1o/uvHw1dxF5Ox7Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659692528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KSNjVUG6R4YnRfpCIx6Z0AzxajKicByex9Au7ZxKnk=;
        b=VJy9FqFKir2Bg7V2kmxAdrkGojKcBAk6os+RAO/SXPTsBnkCcD+KYcoNq7uXuQUh+DZwLO
        8n5ncV0FxwmYH6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42691133B5;
        Fri,  5 Aug 2022 09:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EmowEPDl7GL8WAAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 05 Aug 2022 09:42:08 +0000
Date:   Fri, 5 Aug 2022 11:42:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Can Sun <cansun@arista.com>
Cc:     Kevin Mitchell <kevmitch@arista.com>,
        Ivan Delalande <colona@arista.com>,
        weidonghui <weidonghui@allwinnertech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/decodecode: add the ability to find code sequence
Message-ID: <Yuzl64bME7GUWo10@zn.tnic>
References: <20220804214616.71419-1-cansun@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804214616.71419-1-cansun@arista.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 04:46:16PM -0500, Can Sun wrote:
>  It adds a tool to search code sequence from vmlinux. If additional
>  parameters (vmlinux and kernel build path) are provided to decodecode
>  command, it will try to search the code sequence in the binary, and
>  provide a code block surrounding the target.

The use case being?

objdump -d vmlinux and searching for the rIP is too much typing?

Besides, with the kernel being more and more runtime-patched and
rewritten, the live code differs more and more from the actual compiled
opcode bytes in vmlinux, as you noticed yourself with restoredcode
below.

So maybe I'm missing some important use case but right now this looks
pointless to me.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FC5A73BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiHaCCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiHaCCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:02:18 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3694B3B0A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:02:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BA8661224D4;
        Wed, 31 Aug 2022 02:02:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 107B3122D75;
        Wed, 31 Aug 2022 02:02:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661911335; a=rsa-sha256;
        cv=none;
        b=5j+Ry63NoQ6pOvBnd2/YPqMz9IBt+3CAFnKC7vFzEWFQRDyglp9JA2m22MN14c7Ai9+xH4
        HT5Z3PCvn4Ts/B1KwnU1fKCEGLymYCkLIFh7QIE7QzRIkrQ5/tmuaT/2xrRsO/8hDCBpe6
        FbEyBv5SQrRLmlXBGSQmdoCKVKJWByOv+KimeDBS5woKbo8MYH0P9GBUkM46U5Yy/aWeiH
        qVS5uyvvGjmSal7iD4KWOFX0efFDmQ1zwm1yDpyV/GN8wB1Jo1v+MYrdXjtGLup5KjgUG+
        p81c/FbG2LtMSO721aLTvPCOflkMIJ2diBBTnHDWNH4B0EaZao66CUVYTUBb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661911335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2YbYSFZwi3oLLyj3VoHxYd0lXmJL1xiYlpzmuwgB2l4=;
        b=PzgC5kgq+kLzDNXeBqLZlAvCFyWDKBxnJj8lxJs2HURZmsqhrTQbLCbjK4XBE8LWPClAg2
        WIsND9RiUOwleNdvXYsqIOd0y65wxylBVvPpbA7jSxS8QcQDjgGAzX4vYrYSvgyrkCv3Fr
        9MXfV2GXYVDffBLCqoIB0RdwwWSdT+tOU645JTvsTqQHhMCE2/gEztnkuKwYHINuW7znP0
        nuxU0imSwFWEFwZWGjQlNgJmeueUDiAJafmmdzBB7pGZ8PCvUcKpfq2sWJvjVILny28cwy
        rflc/y2OHZyigp3+Kaf4z/H6Jup1339FmwCYSUwy73kKruIATyolR7jBYdklOQ==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-5vgs7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Chief: 3d24e1ec45b94037_1661911335347_2415526723
X-MC-Loop-Signature: 1661911335347:3241657719
X-MC-Ingress-Time: 1661911335346
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.199 (trex/6.7.1);
        Wed, 31 Aug 2022 02:02:15 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4MHS9L0CS2zHZ;
        Tue, 30 Aug 2022 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661911334;
        bh=2YbYSFZwi3oLLyj3VoHxYd0lXmJL1xiYlpzmuwgB2l4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TiSvAstqKqmIRtcNy4WU8dsWSe2iKcaUmQX1P4U4zQLoVh/Lx34LJDCNES7i4d7BZ
         jAz31PHWeCg9HxNQ9I8Q3fYmuEvk6BuMpJzpMZb6UxpjYc9tAmemnCHu3+nQfpM1y3
         rxCjTFgkOb5YZzkBTlq6fWnkqzdWLwFC9PeT2m2SVq2yNNWkNuxwX6e2Tq5EYpoz+I
         J0K2qRUIer8I2M4dVImMkgYzkC7bcCB1ehOsOIvhpltmw7itdv/t5cvXz0sDGEtyJt
         Xo51i/HckFJYOxOyFUoxGOzIotVWFY30K/G9QHPLObAntbyZ0sok9qKDKloQ/ayOBl
         kgNrD+i2o9nGg==
Date:   Tue, 30 Aug 2022 18:43:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 66/70] riscv: use vma iterator for vdso
Message-ID: <20220831014345.4ftn4xt5qwkreguz@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-67-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-67-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>Remove the linked list use in favour of the vma iterator.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

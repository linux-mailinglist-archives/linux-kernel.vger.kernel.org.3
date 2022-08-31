Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6305A73CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiHaCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHaCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:13:26 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4AB2CF0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:13:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7FB723E074F;
        Wed, 31 Aug 2022 02:13:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a286 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0A0823E1297;
        Wed, 31 Aug 2022 02:13:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661912004; a=rsa-sha256;
        cv=none;
        b=2sZZKJ60j/LHvcjQGJElzSm8D0MZkWgt1+1/25qVYDDZT1faaT470B270EW3yYCx2yZ6Su
        75XfoaU621WFmirWyYpYsibtxLXh7AScEHGD4o1U6JnGtSb5WglSAmFpWyLq+6VMRFILwI
        AgA6fQ9zuGnPLbbvhN25hybPY8bGbgQX33bo6dc/R0hyEwYdb8EbRpR8qaRdWk+BwwpSLN
        oqGUSENPoiTYtJZ30zAjPQXrlsbRZRkzaGRmYy7DIEnJxyj0xJBaQO0hJYY8eZC1IoAozS
        UheLDRDDNDKVIgx/alEE5TvZqsEUJAI6oTY6yOstcDu/D/RNbqBK9OkuIfGaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661912004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2na/1YB6P8pAjhSwDiKAckiFI98TLLaOiftpwQaZCbQ=;
        b=VzTcH2zQ2K7iUV86PMfQ7+S8YacIKN+QZG0Hf1VNuF/MK3uhiHEHtdKOHQKbpM+GxSIZto
        SDjVgmgi/y/4cixec9kCahD2XpSGEplS0lJUdxKJtcBsrTcI4Lz+w/pza2stFiDn4SfcSL
        tu3n+S5p1WpxMggsN5iQQ6hr7lzP6NgsxceeOsyfYCqzz6YBRQoRhXaGyvxe0S7QtezJT2
        PV0kgYyBWKI49C3b73mOntIWtKb0y6AAyZ9iXPpWhlEAZ0Broe3INonQ2TT4rlhWXArF5g
        uRJ62ZLHlyR8cRMe0on4YjVcNgKIYjQUvE80RH9g8orA30tih6PCh2YpkRBC4w==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-xzkt6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Chief: 2b693d20502d7a1a_1661912004303_2191180068
X-MC-Loop-Signature: 1661912004303:4261194441
X-MC-Ingress-Time: 1661912004303
Received: from pdx1-sub0-mail-a286 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.76.153 (trex/6.7.1);
        Wed, 31 Aug 2022 02:13:24 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a286 (Postfix) with ESMTPSA id 4MHSQC29CZz64;
        Tue, 30 Aug 2022 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661912003;
        bh=2na/1YB6P8pAjhSwDiKAckiFI98TLLaOiftpwQaZCbQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RSVJrsC0s9o7yWlqhf1uU4/Fu1o3hlhtpBws8baIe7eMmVAqrKHyi0x5c0WPkCrjZ
         4Zgd1KhxNfbLG/W8X4cgMS9GUsyrdLjgoRYdov7CU6chAnAR4yk9nyKpqIrHQFdCvW
         9mJv8HAEjYw9wFeDVhCHokObriyhgLZgf5pOWZXlx6LLMjelfynRLwmgzyRm15pxlw
         /6QlZWKVTNr1PBRER4U/ufItNi3xaree4UbN87+HpP4heDECNboVcXdFRhp/scwy0o
         XTD0a/hMBIYSpGVUriZtHR57qxFSClIVFCj0QmYQxiWv3VW/DT6sxVFXIJx0Htz8fh
         Ao7CUa9GTGh+w==
Date:   Tue, 30 Aug 2022 18:54:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 7/70] lib/test_maple_tree: add testing for maple tree
Message-ID: <20220831015454.wi5pqgstegvnwnr2@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-8-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-8-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>This is a test suite that uses the radix test infrastructure.  It has been
>split into its own commit to allow for easier review of the maple tree
>code.

It would be good to be a bit more descriptive about the tests and what
they consist of, for clarity if nothing else.

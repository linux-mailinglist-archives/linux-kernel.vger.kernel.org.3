Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070559EC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiHWTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiHWTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:30:04 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0ACD25C3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:18:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 071B4820E73;
        Tue, 23 Aug 2022 18:18:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6D448821C18;
        Tue, 23 Aug 2022 18:18:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661278697; a=rsa-sha256;
        cv=none;
        b=3OQOquQh0Q8RB88NCf+qNQO3S/B9pWZFQCCRYLNKOJoZ/yHCnjcCvYQBVPjH1QVAaPU8OE
        T8ZkQDignUb9tI1HGgWBwQgVDiBGkcXeEIhHRS62BGdVd3Uv3B5uKsdvDJpOL84urlF+4R
        rLZ6sm6GR8Kr18/5urs7xXqVy565pOktvkvEtXMBsXOfao4X3C1hRnLLkchf+ZrEt4q4Gm
        qiaOqCMjqBqZmOWmvrLUqrC9fm9GXICX81dGthSbF/PE0+PX+EiFljW4OyfHJAyHsB0FHf
        T4nqfNap5i2OLs9lKbP3LQjIX+rWyDOYBiIhpCCVzwBbriAkYZD9jXMN6juB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661278697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BoFTfa6Pmpocvq1dOP3/e5ti6Vn5XMkAjsi+9n9j/UQ=;
        b=ByHFOErcDJgQqsw19rbViJvVwQOlgV820SJ0aoyeTu0h9ke1vXgMGurX5byF4g8fc/dcs0
        OIH6pxrw2SHl8bvuH6p7YVzkYem6PpBP6EVuTrXimeDtG13owzyPS1z84/q+DpDG8VV1jm
        g9apbsP7Sv6Q8y4siccvuSCRTkMAGt/aJPg/GaSsPgOfmIB8gjlNOzHMAsxkFKULRkFE0U
        dR5GXuSffWodFI3qMNm3vqy3+B3qU/kFiuZXQ0gETvfLDgE63DjJskIOdJne6cksjHzsrw
        6Y0lpcqNjtH5ru2QbNzkegXK3LV8XnnDOUi7v3Wjc0/+VXTJ+pS06To+ichmJA==
ARC-Authentication-Results: i=1;
        rspamd-76867cc9c5-87nb9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Dime: 288e4e58333a2f8c_1661278697719_300024312
X-MC-Loop-Signature: 1661278697719:1880717708
X-MC-Ingress-Time: 1661278697719
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.194.202 (trex/6.7.1);
        Tue, 23 Aug 2022 18:18:17 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MByCD4pCVz1PX;
        Tue, 23 Aug 2022 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661278697;
        bh=BoFTfa6Pmpocvq1dOP3/e5ti6Vn5XMkAjsi+9n9j/UQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qa3XvDz82ZnJnUPfrl0i3TXqyyyK2VCs8mXsJlNo0jWPe9xSPvMYyrhV1g5uuPOuE
         76zEVM4h04kNFUy+AR+pMXo3SKTVRLZosTz9x7so9AWL8oY+gGoTI9BMjpuBRAFaSY
         oi89pGx8YXTQ0ZryKdUZFsrq3EwdUORiYzk6I1OsALwRsvLfz+LKhSd8Hw4jVaaSyB
         LpjWsb2IfY+e3SBefm/yrXwJkpv4myEhGJatMYwXF2WujmrSsLtxlXTyS1sa5qz7Hx
         W3yuP9OQrfb94aUh7i3qp9Wz6KgD7P0gCbpPqT2Ko/L1Tuj9CCSJV9as3ZXHBVtf67
         7Q+cLcLGYq1dg==
Date:   Tue, 23 Aug 2022 11:00:09 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v13 39/70] um: remove vma linked list walk
Message-ID: <20220823180009.3l2vbcenndiyhuf5@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-40-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-40-Liam.Howlett@oracle.com>
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

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>Use the VMA iterator instead.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

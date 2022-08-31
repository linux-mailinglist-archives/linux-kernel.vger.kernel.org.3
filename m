Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF95A737B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHaBpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHaBpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:45:50 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B6A3D23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:45:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2AEF68C159D;
        Wed, 31 Aug 2022 01:45:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 67ADB8C1249;
        Wed, 31 Aug 2022 01:45:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661910347; a=rsa-sha256;
        cv=none;
        b=mvOgU5OXZ6LY1gtny8HH0q9dtHkp5xJJAobNsJ6ip2T6hWUmCgetI7LMwiOlYqhtaaP81N
        sT5d7QmCc4YbkD++BoDMCUntxWrhSeb2gs5mp6OY+kVLbBZISyCVMg506LKsSJB7Br4Tv5
        drxPbLYHsaTy3ng1twzTUmberCFTkH6oTTjx8A3dm40QrGQP0xb901gkNiigqJh5F9xBnY
        OKIYYkq/uhi/xu8KXV6PoWtN2OCcKpe4lH3AFf6UzIub08JirsJpdS39qVtyLRlXYyAFxE
        tIcg1HpJiOrxhXCZK8WLw0Sxnog3Yu9xbW2e8ajWg8q3Y9O5IHsDUGYqgS8R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661910347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zNLn2dHsTBceRZjkcg1LStmtB3rlWh45ayTcPyrcLHE=;
        b=blDFoOR/GjYl0fhF3eamF93uCySUwUCk3Gb4w+3TCsQ1tdq3Gq8lQIkslxpZUPWpKGsMKZ
        yWfTyK/3WXVWfiUCEY3pRQUqeIDw7kfFojWL5W5qN2SeryJvmXXSmGLphwoQNibT2dFcee
        LbHNCx02KWQIptNTjrDt3Fspj8W1XvdnMcM0nr96ZvaCo51wvenDF8fZ1a02XUjM8oS8BE
        eehG2tYRC2wdml3ZqQA0a/YsR/43FcLLfTYW30eaTrIvlDqQ1UK/sPsJYmSbFVChDaPu/9
        oVAiWqZq6vMLL6MeeRSsOn1c1y88Q5rOK+hqrcUpJWw7JjH2D2MFVDVbTRLFJA==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-b55wp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Shade: 72b42a184c07e4b5_1661910347730_2928235378
X-MC-Loop-Signature: 1661910347730:1075862939
X-MC-Ingress-Time: 1661910347730
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.76.153 (trex/6.7.1);
        Wed, 31 Aug 2022 01:45:47 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4MHRpL59fFz85;
        Tue, 30 Aug 2022 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661910347;
        bh=zNLn2dHsTBceRZjkcg1LStmtB3rlWh45ayTcPyrcLHE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JseY8dJ7s16OJJFy2HwQ9tEDaX3NiudiVgFyfGZNRd1BI7JMhHBGrLCghrMa7KEn/
         f2vpSUqAEt21tmtyHFqG9eDsjVzEB89ta9txEmllTsrcgfqroeERlv9YSrrxhN4xvp
         88OpkqRhOTS5VifxBqwVwWdSaF9NyHBU3RviPqm1VUFPR2aFUIGmdCPK2pwS+4hcmq
         Vy4fNKEMGL6TnW3quPQQxzCNRTasyxyGpO6zhm5KgFzD+kpJTnWAMcPO/qtRNqf0yD
         5M20FU59iEEe+Btv7/RebyItlCbDULX60/1rHQ3NHziWDEUJj1FLLC3XL+F5V0DnWq
         Do/db0qzFgDSQ==
Date:   Tue, 30 Aug 2022 18:27:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 16/70] proc: remove VMA rbtree use from nommu
Message-ID: <20220831012718.srlmcs7nbjql43nw@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-17-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-17-Liam.Howlett@oracle.com>
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
>These users of the rbtree should probably have been walks of the linked
>list, but convert them to use walks of the maple tree.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

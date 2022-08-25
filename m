Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BF5A1657
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiHYQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:06:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113870E61
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:06:51 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E809C5010C8;
        Thu, 25 Aug 2022 16:06:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2A41A501198;
        Thu, 25 Aug 2022 16:06:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661443609; a=rsa-sha256;
        cv=none;
        b=sbkVwbMWptZkRbJ7TzmKNWXybDGaCPt0JhxS/10JwOso9+sBYV1hRWFQ6V7klWclCTxakR
        4wrVapl2kLqwKmuANhbS4cEuNP0TrnKZpIZOPTgWLC90c8R0im6rL4r3entt1NcrDQyk9e
        LNdqdiER5E6acj9vKTvefV4A3HFm1toTh341bbWR5F4W8+ZYzQI9Yz6Lyvdrz6dbJ7BXgN
        bKAEEEWeB5eAoZc5x/LxjRkDQZKLA5ntvskSzPuHX1igFWMusfQdympDPVrTXzvYha/z0E
        TECuD2qqRjFCsSXdJlW/x38lgVQPOf5+8BX4K5V2sd6zah5x3g1+WEXPZKmVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661443609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=anopUDp5ozStsOp7m/DsKCZ3eEuLLawyiGqKJA3EYfo=;
        b=lGt2FG4gSrVInOeojCUUTARhFwV7wqdut9UVpfq4CHQCCuSSH0YcLwQxMv/HDKSJ516rVe
        Feqkhxq2v6qlp6ljPjBLaPFLxk30Dq0l4tYP4iVH6W+vBXno0YNy6zh/xjBsW4sXzL2uYu
        VjLFN1WPvd8CjUhfHLv2XgaFAYZFXzAGSgSdpoHq83KLPeof0dehKUHqPdnX/iNdWZj+KN
        TzqFeCm306oyckPIFIBf7vvCUuoyDMbBMiFnafQAddrc5C1/q6Qgq2sPLM4xPF5R/vj0dC
        hfUPyFuW5yF1lrn/7TgYRz8sdBfncfiDcI1Sg3JG/iljCBpwUwtGNbje3LK1lQ==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-zzmqr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Power: 71a32de35b4d361d_1661443609470_570315058
X-MC-Loop-Signature: 1661443609470:3773033028
X-MC-Ingress-Time: 1661443609470
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.147.32 (trex/6.7.1);
        Thu, 25 Aug 2022 16:06:49 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4MD7BV3bTyz8T;
        Thu, 25 Aug 2022 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661443603;
        bh=anopUDp5ozStsOp7m/DsKCZ3eEuLLawyiGqKJA3EYfo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=FCqflbpmhi7z3AuP4xA5X4muM6qXt/oe/drsE4vIXd663b2lVCrikVJQX2BSzgOIp
         ovWp/KS8Gb6VnLzKAhntjltZ2MFkpmIuiYY/nDimA+jQvbEmR7HITtmArfn3GgBJLy
         LiE+L92SLXCdojqBXF0A3DWMYormLFC8KbMbBf+soq4lIBVJ4JOnmezbBDf1ZCIh+U
         90MpeWwMbC7jwb+rMn0QJN5kV2gipxlvjqrFc2et00AlOoKVkjhIg1caQfqIosM2zw
         mAaSQB9lDufTsOuKhLdmmOTIiD3QtO63pNqDPwcZVBZAo2+6Zh82WAfJ6R2CVOGGZT
         lu5QcLjQtmHPg==
Date:   Thu, 25 Aug 2022 08:48:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v13 36/70] xtensa: remove vma linked list walks
Message-ID: <20220825154830.jb46malqyy3qme3e@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-37-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-37-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>Use the VMA iterator instead.  Since VMA can no longer be NULL in the
>loop, then deal with out-of-memory outside the loop.  This means a
>slightly longer run time in the failure case (-ENOMEM) - it will run to
>the end of the VMAs before erroring instead of in the middle of the loop.

I don't see anyone minding this.

>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

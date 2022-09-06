Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E65AF257
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiIFRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiIFRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:23:28 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BE87695
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:12:55 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8C4C56C2016;
        Tue,  6 Sep 2022 17:12:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1ED716C2134;
        Tue,  6 Sep 2022 17:12:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662484373; a=rsa-sha256;
        cv=none;
        b=ZGkN1AkwtdY9QbLFTg0nFhCDJ2s6NnaAkGXpR13+blBlsrQODuy4fOiujyJBCZU1uAgeF3
        gnvz+GrjtteY93XZuNVTvOV7BMqjXpoZMLMd2rmveC2oNVPrELzDBxPqcEmpRNFHsqqBly
        ZETNFsJlJnWlxFQ/O3Jps8rvp0cD/GM/5nAQcV/sUiYxWHp3h3j1h5iz+akd5J67egBKfB
        Qwi9DL99POrVPiRgSIqzcyHXVSmQNoTvoD9cEkGSphHj3dwHslBmrCPDI67iWg12QSq8L4
        xUZzpCBsjhPg7aJHd3GQA/9GBFOiTlA3+mbgBVJAMi9mBw2rxCxMBvdCf032wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662484373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=162NvlXlce/ajvDF/pu6rU6DTQ7WpeDjyxmRGs3LqRk=;
        b=8yN3MWY1CSAeXtaNQhbaYFs5n+ppORCxPS0+cskPKxyeR+fzKZN/S7TMIUp3ns6ie85o11
        eHRjrPAwW55HQKr1LUhK9sZmTUaLnS1btJjjRycAsQ+a+BDmSNqNGSyYkLGPF4xCC/EXLj
        P89vdmO1/O/Ylz1HdQQcB+qm8gKA99F4CN3LzeuTVGK3hP1BYYVPeC2v0YEKaemEDByc8b
        9ATN6GdgO1WtpH7FTUINv7K//AIDVXz8Gx/4gwdJWUcUDvEeycIKTG+uEtGv2QaK0YQW8U
        I0gOsSGXpsA0qmAFtFv2FPaJkWVIk6uaA4jgonPTtqVaL3LTiyikROG0f46org==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-4528g;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Versed-Wipe: 18e02d57674e1123_1662484373415_3098781220
X-MC-Loop-Signature: 1662484373415:3983678406
X-MC-Ingress-Time: 1662484373415
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.155 (trex/6.7.1);
        Tue, 06 Sep 2022 17:12:53 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4MMX5J1CJHzB1;
        Tue,  6 Sep 2022 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662484372;
        bh=162NvlXlce/ajvDF/pu6rU6DTQ7WpeDjyxmRGs3LqRk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=IrebXoKY/oVFhttnmdep9cJW9mMhnDfzXfI+OISy+M36yJ2H1ARUyUmIbJmIhrUkg
         Poesta5TlL57oTTTuK0RKZCPH9MC17p034QqTaTYUTCSW4GjX6tLozhU43UqhlmHl5
         LorJjmU6XfW/OSW5SEbthDUzpYo8kpFPPrRujYffwJuZNUY9vuZp4QN0LxXcGiDcE9
         bBLLOEniIERLK/CFat5VNxImUYmQxt+6O7anPLk7qkwhYPn0OlyCGH/ZP8hkbjItqy
         BUQCveK6y/dDVdYtOekMGGKc+sC1b3DC6SCJXAKUtpk8HOL6HI6NCl/9B5oXSACWUk
         aFbsFQzZeoEsw==
Date:   Tue, 6 Sep 2022 09:54:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 54/70] mm/madvise: use vma_find() instead of vma
 linked list
Message-ID: <20220906165400.rfdivae7hlqdcatl@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-55-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-55-Liam.Howlett@oracle.com>
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
>madvise_walk_vmas() no longer uses linked list.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

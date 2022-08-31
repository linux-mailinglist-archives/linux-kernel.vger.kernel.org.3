Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC35A744A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiHaDNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiHaDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:13:46 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61388B089D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:13:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 98C65200756;
        Wed, 31 Aug 2022 03:13:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a278.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 186A6200872;
        Wed, 31 Aug 2022 03:13:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661915624; a=rsa-sha256;
        cv=none;
        b=NDlqQmnUgq+tbXJnaPIG++EBhAVyoQpTFrSK4nT1lVaG8GODe9oLKeKgozsm64jO54d/BG
        qePnbCRW4OAt6xYrCvm0v463abGGZcbNKxPbnLE2Zqy09cR1QrAiqbDWLQpp2qq85bQl8I
        q3enqXzDX4/PNngkzbzDJSAB1+vz1wK9ymxgplLRzyADmiJhF4qLIJAFEaLI6349Wbdhos
        0O2E+hUg22zZU4Pgl5JykT7dA0lSB+hcAe1JP+iMFoBHseKy/twYYSBwEat8aQ4WEd5lW9
        neG2MQVXWpFXs+PcNRp375YMYfixG1k9077q6zVT8TH0L1Nr0pj23U0e/Pw1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661915624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+rDV0qPxYoZzTSTxFKsZ4uhoRDErAZbqYP14M4Dp9y8=;
        b=t5D1Omwjqt3oxNNTOT0WF2Xp56/IX1j/XQsDXA3JgWYeiTmqZUk99Ud4fuubdoiZDA4uL4
        cI2TtLJBOf/f3L/WAqE5Zbo6aF3zTYvOcnsKA4C7wPca/Z45AAoq7jBmIgtOTnH9t+zcE/
        Y/qsXj+4wfVjRjEEfHpfM/aLuimGb1kq+jCQbNSyXRmykf4qj4IPf6whTUL8lh+rgei7UF
        uTpMbuguYeGhUh1YCOICyoC+xCPqMHuZzv8EpUIUJYEGEI6URYZ/L54oRM6X4QYd2cDERW
        H+n7wxTAvZCWFdUhmfiCQK3VFhmloSfinDcaoly0kCvJqmXbzOBHgYZIETqeEg==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-rntk9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Language: 110a9f4638e518a0_1661915624368_3246741728
X-MC-Loop-Signature: 1661915624368:3935098745
X-MC-Ingress-Time: 1661915624368
Received: from pdx1-sub0-mail-a278.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.142.80 (trex/6.7.1);
        Wed, 31 Aug 2022 03:13:44 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a278.dreamhost.com (Postfix) with ESMTPSA id 4MHTlq334Cz4s;
        Tue, 30 Aug 2022 20:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661915623;
        bh=Yvt0qLRlYZiGyNfbqiCk1P/Ut4i3/2jws/ZM1Sad9Ls=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=H0+j1Ct84X8z5/Q+YDBneggSZf9z4/ybyR0spYSKZCdPfP+IvSjZpoOkXAzxD+Y38
         VWFVteP8XBlQB9USRtqupDGQ2caZHd4OZZiiPwLD419RaVydl0Cy5fzUicJoK9OS8I
         ack4x+otbWYetmmkBKC6/dmw31tMaglogabmOhfwPAP9TvCrXs/c/AbvMTqXR7Lfz7
         tOnPazt88ke8HTr+DWAQIIo6s0ZlOuGX2vyHAUAZEh8fbnH4gVwpg2rRF+JjEyDw7l
         ieHDY/IOfdr6mqwKhZ0fcBT8Mwa6t53iyoP8RU41apXAKrDxRcMttytocliMEQS0TX
         AI5LeqvfNoxCA==
Date:   Tue, 30 Aug 2022 19:55:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 60/70] mm/msync: use vma_find() instead of vma linked
 list
Message-ID: <20220831025514.75l634odtvm3n6xc@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-61-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-61-Liam.Howlett@oracle.com>
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

-ENOCHANGELOG

>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

... but looks good:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> mm/msync.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/msync.c b/mm/msync.c
>index 137d1c104f3e..ac4c9bfea2e7 100644
>--- a/mm/msync.c
>+++ b/mm/msync.c
>@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
> 				error = 0;
> 				goto out_unlock;
> 			}
>-			vma = vma->vm_next;
>+			vma = find_vma(mm, vma->vm_end);
> 		}
> 	}
> out_unlock:
>
>-- 
>2.35.1
>

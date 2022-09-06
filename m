Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890025AF38A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIFSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiIFSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:23:23 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F298377
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:23:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7C52B22246;
        Tue,  6 Sep 2022 18:23:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 06907223F8;
        Tue,  6 Sep 2022 18:23:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662488592; a=rsa-sha256;
        cv=none;
        b=YGeGrjdf7lPx1ysO2ryuqeG8oQlJeh64+uQlc9AqH75eSE2X2SNKiVsUIGrMIFEzRf2TYB
        Yk6AmOMHFVYLf9tHRvzhKqUabh9MnmIe3T+2cUjSwIqyMgIduYxozHLqNvo4u3a45Ksls3
        fW/8uPlN0dcMzSIKpyG3/3hmabT5KZ00UYB+X6Xj+xrk7KKuImkkWwAmPYRR8b6/1gP0jX
        Y4s07ysn59n9kqn+uSfmCkkfuk5S0JmvypE34u816dm1yPoWB4FfnlcKGEhAEAyzqW7VyG
        OwrpupZK4aypwqpV5yzYr/YxiX0EoweKzae/GOOT3GjLSrOJKdrDCg0NLLzF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662488592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XA617++Zv+kvhwOfHvoq94h2T85fV366jfZIsfdI8V0=;
        b=TySZ0TQY5AUAtfpt3dmnUnKAHQzoTVGkupR0llPrtjVcA2UMGMPHncd5p1vVptzz/qW+AJ
        9im4qTcILhEm5cWksOrlhrPOogAwmSUKhS2yA6TfHDTMLSBt/aSa0GvuNr1AZJCMNLNfoz
        +Q0AXVvjTVEg5tgVj+Q5RF7W64MDQhlOeSV6DfwQyKp7cx9FjU9FyJQykmzVb1X2HS4S9J
        nB68Hw1hJ7tz4uSMFYjsuyZHu+bqQFrWFzOWVQf//AGN9vYtrH+YztdiZ92dBl+yLm8AQj
        aUoxRvQjIzwfanXOCLIEIcKILlRyM1iBcMgIfrOlRj+I/fHP/WojIdzKLThn4Q==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-p8v2v;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Whispering: 660cc1d453c6b917_1662488592320_3961185797
X-MC-Loop-Signature: 1662488592320:3984289857
X-MC-Ingress-Time: 1662488592320
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.66 (trex/6.7.1);
        Tue, 06 Sep 2022 18:23:12 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4MMYfQ5PbBz76;
        Tue,  6 Sep 2022 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662488591;
        bh=XA617++Zv+kvhwOfHvoq94h2T85fV366jfZIsfdI8V0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jfJeRT3lGeWdDzpZT88wsgsmB8V4RtaS/fam4EVS7+1rAEjtnnhTWRjNGo+wHUTdy
         7r6ntfwUYFjHwwicXjSpC8TpiLX766u1sJVPSp8l1P4JN30jFerWMazR+GwPa5V2Vr
         7UGldKlzEXMIOro293icBPLVhlVKacYomPz8HXVnSmPIemsmGE2VX1zz2JMmFu0lT1
         BRmEepqo7Lcb7lqSKyZvP2AJMtQXiptF0YtFpMQBvfcViEYvRBnr9drR8wErWoTbtB
         qi9BHY49kld9rj1W4w4aFjtnDXjcxS5U6lSoSpcMttN1d30/NYt75D3LgB8/QwAfrl
         3o+vtUaP00fGQ==
Date:   Tue, 6 Sep 2022 11:04:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 59/70] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Message-ID: <20220906180419.as2j5mfg4dzx2ssm@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-60-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-60-Liam.Howlett@oracle.com>
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

-ENOCHANGELOG

>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> mm/mremap.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index e0fba9004246..8644ff278f02 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> 	if (excess) {
> 		vma->vm_flags |= VM_ACCOUNT;
> 		if (split)
>-			vma->vm_next->vm_flags |= VM_ACCOUNT;
>+			find_vma(mm, vma->vm_end)->vm_flags |= VM_ACCOUNT;
> 	}
>
> 	return new_addr;
>@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> {
> 	unsigned long end = vma->vm_end + delta;
>+
> 	if (end < vma->vm_end) /* overflow */
> 		return 0;
>-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
>+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
> 		return 0;
> 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
> 			      0, MAP_FIXED) & ~PAGE_MASK)
>
>-- 
>2.35.1
>

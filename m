Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A14CDBC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiCDSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiCDSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:07:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39D22E19
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646417204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pE+I/gRczZg4GsJx4FZniE22MNELy2Ncp1BxXucUrMg=;
        b=Jc3J71VMfEE6lVURD4gXvv/d8wa539EnNkQETs9oKTXDl6truCmCbh/wvuGBy/q2AE74DX
        0P2AkzZYaTPWDtGf6XLcVRsNSojooLAtZ/77GjAjSTEJH3MlpdBZjYluTN0rvnXLKOJOP5
        DXlXEti3cB3HRe/bdboBlwm3txV+oYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-gtofnjRQM-uBC5kwvzSJBA-1; Fri, 04 Mar 2022 13:06:41 -0500
X-MC-Unique: gtofnjRQM-uBC5kwvzSJBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B0B5200;
        Fri,  4 Mar 2022 18:06:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 786FB106222F;
        Fri,  4 Mar 2022 18:06:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  4 Mar 2022 19:06:39 +0100 (CET)
Date:   Fri, 4 Mar 2022 19:06:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Message-ID: <20220304180636.GD19636@redhat.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03, Hugh Dickins wrote:
>
> Just delete that optimization now (though it could be made conditional
> on vma not having a set_policy).  Also remove the "next" variable:
> it turned out to be blameless, but also pointless.
>
> Fixes: 3964acd0dbec ("mm: mempolicy: fix mbind_range() && vma_adjust() interaction")

I can't believe I ever looked at this code ;)

Acked-by: Oleg Nesterov <oleg@redhat.com>


offtopic question... can't vma_replace_policy() check vm_ops && vm_ops->set_policy
at the start, before mpol_dup() ?

Oleg.


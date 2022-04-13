Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FC4FED24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiDMCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDMCuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C404849F3C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649818084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HL4I/kbAi4EMYznQst2SX99qMFId0RHWKlLCdi0UXhg=;
        b=VUcnPMhey8K/t+VwbhF/6deXa6Wi7G4N0kkCZcXAlFKMZkhwboOF0YeQMCQBoRgJ28i2c3
        JmCV5j+JqdKI8ILyuDa5O9NWU6Ca+Fb8uxpNHCM/OhHqddG9+YopAMUl+Dx83ULVW2lRwK
        XoE8Q2oD1HBFAvpXmyJ/cFUeEL/VuzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-QIkJcyNEMZaTlr0_V49QTQ-1; Tue, 12 Apr 2022 22:48:00 -0400
X-MC-Unique: QIkJcyNEMZaTlr0_V49QTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C77D3101AA44;
        Wed, 13 Apr 2022 02:47:59 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B0A2024CBC;
        Wed, 13 Apr 2022 02:47:52 +0000 (UTC)
Date:   Wed, 13 Apr 2022 10:47:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, dyoung@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
Message-ID: <YlY51XjPFN1vMvQV@MiWiFi-R3L-srv>
References: <20220223113225.63106-1-bhe@redhat.com>
 <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
 <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/22 at 07:27pm, Andrew Morton wrote:
> On Thu, 31 Mar 2022 19:32:17 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi Andrew,
> > 
> > On 02/23/22 at 07:32pm, Baoquan He wrote:
> > > The memory leak is reported by kmemleak detector, has been existing
> > > for very long time. It casue much memory loss on large machine
> > > with huge memory hotplug which will trigger kdump kernel reloading
> > > many times, with kexec_file_load interface.
> > 
> > Could you merge these two patches? Or should I ping x86 maintainers to
> > take them? 
> 
> Ah, sorry, I tend to fall asleep if there's "x86" in the subject. 
> Poking a sleeping Andrew is always the right thing to do.  Shall look
> at them.

Thanks, Andrew.

Since it's also MM related, so ping you and x86 maintainers to see who
can help pick them.


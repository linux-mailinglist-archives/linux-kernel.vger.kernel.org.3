Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290494F366B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbiDELCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiDEIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7710114C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649147656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z65CXYbIBUl/IlVCrlM6BZQKF+ZppxomZMYuDllBYxE=;
        b=FgxQGsUhQ6/Ul6iA5ukP1u5jptq6njHxozoGUJI7Ky1QS0VITiCW0eItR4vU/q6m/I5uiv
        yhKiPpg6P/YPU1tE1bikZr/Lz5I42NNsSGkXxjdjXnjr0arQhnsTnC2/tPGLvPP5mlIXtg
        5gRVyDk6jGBOohC/CwWAW8YaGuJ0gUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-bYIfSXvxPQ2HCL19_IPyWQ-1; Tue, 05 Apr 2022 04:34:12 -0400
X-MC-Unique: bYIfSXvxPQ2HCL19_IPyWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CF3F38025E9;
        Tue,  5 Apr 2022 08:34:01 +0000 (UTC)
Received: from localhost (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28080145D850;
        Tue,  5 Apr 2022 08:33:43 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
In-Reply-To: <20220405012015-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
 <20220405012015-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Tue, 05 Apr 2022 10:33:42 +0200
Message-ID: <87ee2cexp5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
>> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
>> >> Hi, Michael & Lei
>> >> 
>> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
>> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
>> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
>> >> for a revoting procedure?
>> >
>> > You can but not it probably will be deferred to 1.3. OK with you?
>> >
>> >> Also cc Cornelia Huck.
>> 
>> [Apologies, I'm horribly behind on my email backlog, and on virtio
>> things in general :(]
>> 
>> The akcipher update had been deferred for 1.2, so I think it will be 1.3
>> material. However, I just noticed while browsing the fine lwn.net merge
>> window summary that this seems to have been merged already. That
>> situation is less than ideal, although I don't expect any really bad
>> problems, given that there had not been any negative feedback for the
>> spec proposal that I remember.
>
> Let's open a 1.3 branch? What do you think?

Yes, that's probably best, before things start piling up.


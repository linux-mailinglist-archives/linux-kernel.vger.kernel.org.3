Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D624D8277
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiCNMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbiCNMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DF14B407
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647259197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DTumIzkUVMCDvmMhaJUDyMiG+aNJUlziXvFqILOQYsI=;
        b=Fx8sD/JbdyLzP94A+V1xfdOotmYcIHm5ISvnQ1T6ndEogXzV7TyfCtDPGRf0p6VsegfNy3
        bsIYugzTUMz0IuHNj+aJqTOdh7hc3YIRq0GfcMbMz2X9Lov5XQZX8WQYcB7+3myGY8KD6t
        oMsYqiKDn0QvQOa0h6KBhlk3n/P0HXs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-Y-JefBWWPk6yX7A-kJ9QrQ-1; Mon, 14 Mar 2022 07:59:56 -0400
X-MC-Unique: Y-JefBWWPk6yX7A-kJ9QrQ-1
Received: by mail-wr1-f70.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso4268343wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DTumIzkUVMCDvmMhaJUDyMiG+aNJUlziXvFqILOQYsI=;
        b=ZuzIMK4S4jQhVwN/J9SqY90hKt3y5tuYd0Le1uhWwYXFxrqBwl/jQoVXdqpMkptwFS
         6Oj+X3HSMgbrbgf7B8jPw90usbnC2GqNKWT0c6rN4NoM/3NGRcQaboIbOQCaAbed3rI/
         jtOOiDAD3LXjsuVCIuS8uXQnrbn6wcIYjCfiCJjD5Z8i+TG357CMOnwZgDdQ+2CBRryL
         52Cn69QN/ytePuL6nlP2FJMWU1vdgXi4X3VW/inJfef5a84roThCsXZddMEewoSn+zFP
         p+RlZybliiRWlLdXZNfkE2yBhqefOqnXPs5cH1synY9r8UD6QxbCW9ig3zdSZWHFkLSl
         LLgA==
X-Gm-Message-State: AOAM530SbCxrnhCknzC4Clg6wjmk8OeoQa4IVIVZfWNCdqyb5BnFLupD
        rNMiLrqz/LaPrT7L4jmDVizqMJcWhplq7s31OQRqcDUP5GNuozguYohCaPJV1hRAfgDxJJQ40iq
        XLh57b3v/y9QYsS/m0WpiTeIN
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id l9-20020a05600c4f0900b00389cf43eaf8mr17160220wmq.201.1647259194497;
        Mon, 14 Mar 2022 04:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp7ZJAVv6i97GoEYXJTrh4j1WEgqWNchpszO38kLqkQtDsjqJCu3h0XIEDXpnWhcBdQ3hpYw==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id l9-20020a05600c4f0900b00389cf43eaf8mr17160208wmq.201.1647259194258;
        Mon, 14 Mar 2022 04:59:54 -0700 (PDT)
Received: from redhat.com ([2.55.183.53])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm13416882wru.33.2022.03.14.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 04:59:53 -0700 (PDT)
Date:   Mon, 14 Mar 2022 07:59:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, jasowang@redhat.com, mail@anirudhrb.com,
        mst@redhat.com
Subject: [GIT PULL] virtio: a last minute regression fix
Message-ID: <20220314075951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3dd7d135e75cb37c8501ba02977332a2a487dd39:

  tools/virtio: handle fallout from folio work (2022-03-06 06:06:50 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 95932ab2ea07b79cdb33121e2f40ccda9e6a73b5:

  vhost: allow batching hint without size (2022-03-10 08:12:04 -0500)

----------------------------------------------------------------
virtio: a last minute regression fix

I thought we did a lot of testing, but a regression still
managed to sneak in. The fix seems trivial.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: allow batching hint without size

 drivers/vhost/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


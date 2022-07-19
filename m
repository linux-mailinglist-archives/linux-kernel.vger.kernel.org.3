Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D0579FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiGSNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiGSNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB1D350073
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658235159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYVq4WjdOQMHhc5px4YCUTqr6DUNRdDOEbVtXRDK/f8=;
        b=KdPQSz+zgnt+ng130VvTcFmbdrxgShtQj8fijy2ZAvzjQkR18U8ZdYGwv/osLK7Igc/ZZf
        +pKYzKTud74ErJlfesedw1q0dCVUEVJZBwSofI7yVTUkra9JgAC9khVs3AhPiYxENz/DIj
        js7Z5BUjOelpDUqEue/WgSvAR2eVAmE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-Yre2bPGzPWK4rJwEIzEjcQ-1; Tue, 19 Jul 2022 08:52:38 -0400
X-MC-Unique: Yre2bPGzPWK4rJwEIzEjcQ-1
Received: by mail-qv1-f71.google.com with SMTP id l6-20020a0ce846000000b00473fbfc0e87so697418qvo.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYVq4WjdOQMHhc5px4YCUTqr6DUNRdDOEbVtXRDK/f8=;
        b=Vf7IkWYIhXze/DLBqgfr2ftQSWEJMB6iIU9BJY/hkGzXEhqO2iFgrRcy9Pi46h3cRj
         6nXX27xcz2nu1ArpSVBWVmaUPkeIS/G6tMuS1DPKcQNpArJK2l6dIiFoGJ7TKmLXdBKJ
         e6Y55gPXz50fFxMkVsEO8sCv0pBbULnnfEtLhZiEtjOQcI7EZgdCQM34InIR4t6DLo1W
         0/aYywhdU3Jti4Kx1XPQ6o93wT5OfH5VxK+Bc0bFGk3q2XU/l1+lTzr8r62uEnbTMmku
         ssQpOpd2m8/CUgbH7+itBqHaTN2BgEbobaQSrutdZoOTxkykekMD51olsmuTPVFUQhSH
         RfJQ==
X-Gm-Message-State: AJIora86DwUP07Oog2OvhRBb8rhC07LleKtHENNbZP1SfIc1yS8mIsQE
        kCIEqSFQ44vpgnLUVSZ9LQWg85P/iMEAylmC9/suYy0TBPS7qjrW9wES5XRQPS6mJSgwKKFhdKT
        LalL1bV47nQ5/virc6aiINElI
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id 20-20020a370614000000b006b5cda7694bmr13081905qkg.532.1658235157514;
        Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9pkG+DbLrrLN376mRVwAbaPHBtJQ48OByRq4neWnlpWQY9teeIXv+aG4MfOrc28E2dEFUWw==
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id 20-20020a370614000000b006b5cda7694bmr13081889qkg.532.1658235157281;
        Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a269a00b006b5ba7b9a6fsm13373178qkp.35.2022.07.19.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:52:36 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:52:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] vsock_test: POLLIN + SO_RCVLOWAT test.
Message-ID: <20220719125227.bktosg3yboeaeoo5@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <df70a274-4e69-ca1f-acba-126eb517e532@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <df70a274-4e69-ca1f-acba-126eb517e532@sberdevices.ru>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:19:06AM +0000, Arseniy Krasnov wrote:
>This adds test to check, that when poll() returns POLLIN and
>POLLRDNORM bits, next read call won't block.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 90 ++++++++++++++++++++++++++++++++
> 1 file changed, 90 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dc577461afc2..8e394443eaf6 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -18,6 +18,7 @@
> #include <sys/socket.h>
> #include <time.h>
> #include <sys/mman.h>
>+#include <poll.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -596,6 +597,90 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
> 	close(fd);
> }
>
>+static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>+{
>+#define RCVLOWAT_BUF_SIZE 128
>+	int fd;
>+	int i;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Send 1 byte. */
>+	send_byte(fd, 1, 0);
>+
>+	control_writeln("SRVSENT");
>+
>+	/* Just empirically delay value. */
>+	sleep(4);

Why we need this sleep()?


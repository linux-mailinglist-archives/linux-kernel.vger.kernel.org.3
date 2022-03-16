Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA254DACE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbiCPIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347296AbiCPIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7310264BF2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647420682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMlu3K6eKY9U4Sitc08oOJDaydm2FxICxmkEb7WkAjg=;
        b=MX2+1iTrJ17PSfSkT7aTUfMz8DdO5ObOHm0UFGlgG7KxRmhLXqyQyw7ShcyBHw1M1h0+BJ
        dRZjVXmfQDFQkGuiuUaN1BcMPrqcW32JUA/xMAlXfG60waRkz7tW5cSTcPnVKCTY+inyor
        qMs6t/+XuyK8pDEcdw7zIsXYNrDqa3U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-UPGr_FhCPdWKvZs9eoWHKA-1; Wed, 16 Mar 2022 04:51:21 -0400
X-MC-Unique: UPGr_FhCPdWKvZs9eoWHKA-1
Received: by mail-qk1-f199.google.com with SMTP id c19-20020a05620a0cf300b005f17891c015so1050236qkj.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMlu3K6eKY9U4Sitc08oOJDaydm2FxICxmkEb7WkAjg=;
        b=NLugdQVfS3T7A0COI/694GN1Ob1jMvMc3GioAttB/unpgvlv7YHdZrLwWnYOT5OAH1
         LrHbp3zh3Wa4b0rmpI8XKLHrrsOY7skTvrnSkmE6Euv5OxHnfK0+Lt7zCtOB1SDj5r/p
         V+Buy6gevRf24oJ12J+08LO4+otVU+gfxonJj2XpYLDE1j9mlzeb6cegbkpMEeI+qBM3
         8Eml1v/a7hqY2+lnrptK5hQCooh/SVN1oXq/HOexw2kirEN+31PCivgiVzVLJccJ4/yB
         IYF38Kb5jVfPW4rfYdEEaKnRZIaIqnFLvgRyur5SyPzWjoql3ebPQQrhGqOWe+3ctI1f
         epTg==
X-Gm-Message-State: AOAM533CUnD8stXW1XH2LrchzjpQcriMYY3VNY5R+slQ+u4RoxnM+TuN
        ngVGCx7IpMu765HDoY9vovZfOFwAkQKMSVRqBTmPg/ThHrgZlc5UtQbfgSltiFAm7Ny4wtC7MBN
        0VS6nOT7SwBIQuQ+LJFClExhM
X-Received: by 2002:a05:622a:13c7:b0:2de:6f6e:2fe7 with SMTP id p7-20020a05622a13c700b002de6f6e2fe7mr25263106qtk.198.1647420680816;
        Wed, 16 Mar 2022 01:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuAi0JfY/QXj6XW5ZULZlBNrdNUKgIdO1Q5oMPbc2+3FSG4vHPDg4XW/kGbXoPQVPYst4s7Q==
X-Received: by 2002:a05:622a:13c7:b0:2de:6f6e:2fe7 with SMTP id p7-20020a05622a13c700b002de6f6e2fe7mr25263088qtk.198.1647420680549;
        Wed, 16 Mar 2022 01:51:20 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.retail.telecomitalia.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm641043qkb.65.2022.03.16.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:51:19 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:51:13 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Cc:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] af_vsock: SOCK_SEQPACKET receive timeout test
Message-ID: <20220316085113.jlkj7cflzg77akmm@sgarzare-redhat>
References: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
 <2bc15104-37e6-088a-1699-dc27d0e2dadf@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2bc15104-37e6-088a-1699-dc27d0e2dadf@sberdevices.ru>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 07:27:45AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Test for receive timeout check: connection is established,
>receiver sets timeout, but sender does nothing. Receiver's
>'read()' call must return EAGAIN.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> v1 -> v2:
> 1) Check amount of time spent in 'read()'.

The patch looks correct to me, but since it's an RFC and you have to 
send another version anyway, here are some minor suggestions :-)

>
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 2a3638c0a008..6d7648cce5aa 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -16,6 +16,7 @@
> #include <linux/kernel.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>+#include <time.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -391,6 +392,79 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static time_t current_nsec(void)
>+{
>+	struct timespec ts;
>+
>+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
>+		perror("clock_gettime(3) failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return (ts.tv_sec * 1000000000ULL) + ts.tv_nsec;
>+}
>+
>+#define RCVTIMEO_TIMEOUT_SEC 1
>+#define READ_OVERHEAD_NSEC 250000000 /* 0.25 sec */
>+
>+static void test_seqpacket_timeout_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	struct timeval tv;
>+	char dummy;
>+	time_t read_enter_ns;
>+	time_t read_overhead_ns;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
>+	tv.tv_usec = 0;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>+		perror("setsockopt 'SO_RCVTIMEO'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_enter_ns = current_nsec();
>+
>+	if ((read(fd, &dummy, sizeof(dummy)) != -1) ||
>+	    (errno != EAGAIN)) {

Here we can split in 2 checks like in patch 2, since if read() return 
value is >= 0, errno is not set.

>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_overhead_ns = current_nsec() - read_enter_ns -
>+			1000000000ULL * RCVTIMEO_TIMEOUT_SEC;
>+
>+	if (read_overhead_ns > READ_OVERHEAD_NSEC) {
>+		fprintf(stderr,
>+			"too much time in read(2) with SO_RCVTIMEO: %lu ns\n",
>+			read_overhead_ns);

What about printing also the expected overhead?

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("WAITDONE");
>+	close(fd);
>+}
>+
>+static void test_seqpacket_timeout_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("WAITDONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -431,6 +505,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_msg_trunc_client,
> 		.run_server = test_seqpacket_msg_trunc_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET timeout",
>+		.run_client = test_seqpacket_timeout_client,
>+		.run_server = test_seqpacket_timeout_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1


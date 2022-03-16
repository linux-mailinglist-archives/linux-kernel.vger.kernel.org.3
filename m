Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69F4DACF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbiCPIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbiCPIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9661E381B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647420832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGSquJZfEU0XpxQDlJiQ9Nf/2e2vYgQ8cePX8MYx0lw=;
        b=NaKceCeMzi+8eQlwKGa3FS+Iztj9I5oSF9mwUzNFWradIwQ//MNrP6fSyC6Nh89MJ6e7yF
        AN2ChVQHV+hfjkk6Xo1ETvaS8JgFu16VG6LL2f3QTVWSw/uNNgMW7P124QI2S6V5Y5JzKw
        kIZKb0YCmp+SR++5wz9a0TEtqMcmWjI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-Pv7d2SSCMZqUAl5L1ikAHQ-1; Wed, 16 Mar 2022 04:53:51 -0400
X-MC-Unique: Pv7d2SSCMZqUAl5L1ikAHQ-1
Received: by mail-qt1-f199.google.com with SMTP id q24-20020ac87358000000b002e063c3d15aso1082440qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGSquJZfEU0XpxQDlJiQ9Nf/2e2vYgQ8cePX8MYx0lw=;
        b=trWpwUeNS9NT1/esoAuyXYNejnqFQCFp3B3qMJjdw/pm/efPNKcfLQ7oDQI8JQuKRm
         UWGzvJ01pibM91dF32pCVQ9NslrIDIPh15YxD6K/VHJK5YwoIL8oaQkHrlTHZCDpGa7w
         EKC/pjoeS3aCFX+HuKSr0zFGYYiznunhd73gloHPgOWainY/vyVkAMiEFVI9GfuP+nGH
         aEjxBsvRWRz9f6Ly+f/Lsi6pNP5hpDhljqjVIVRllva0lXStyCl4w4erVHtM5qBsXe/r
         6j1+8qz4XDeEEm53rIsSvWRRINslLXiFGckM41KRyTfiRrKcyeOnLsKX/OO1kSA4xnEB
         NPKw==
X-Gm-Message-State: AOAM530nM2tIzlzFpJBjYkaUvGKY2vn0Y3nNP8e2cZzlTXDExsrBBZ1/
        xnn94YXHcV/92CHAUGtt+s2gcuyi/F9wnOqKLnHyJCKzHEwX4N8G4rojVEgwvyedwuDVEvJcU77
        M0B4LW8n9Hhf+1DwUV6m6QcTM
X-Received: by 2002:a05:620a:4085:b0:67b:315b:a09f with SMTP id f5-20020a05620a408500b0067b315ba09fmr20513445qko.334.1647420830984;
        Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb/nFj3dDrpxdws1scoeFcog8y/RQk9LTO0D1ZDQQyiweerrLDje3qSyAQR/5kQ8Sr9cHm0Q==
X-Received: by 2002:a05:620a:4085:b0:67b:315b:a09f with SMTP id f5-20020a05620a408500b0067b315ba09fmr20513439qko.334.1647420830768;
        Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.retail.telecomitalia.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id t66-20020ae9df45000000b0064915aff85fsm638399qkf.45.2022.03.16.01.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:53:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Cc:     Krasnov Arseniy <oxffffaa@gmail.com>,
        Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] af_vsock: SOCK_SEQPACKET broken buffer test
Message-ID: <20220316085345.ajfmnzg3vx3o3vgs@sgarzare-redhat>
References: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
 <415368cd-81b3-e2fd-fbed-65cacfc43850@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <415368cd-81b3-e2fd-fbed-65cacfc43850@sberdevices.ru>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 07:29:28AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> v1 -> v2:
> 1) Use 'fprintf()' instead of 'perror()' where 'errno' variable
>    is not affected.
> 2) Replace word "invalid" -> "unexpected".
>
> tools/testing/vsock/vsock_test.c | 132 +++++++++++++++++++++++++++++++
> 1 file changed, 132 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 6d7648cce5aa..1132bcd8ddb7 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -17,6 +17,7 @@
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <time.h>
>+#include <sys/mman.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -465,6 +466,132 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define BUF_PATTERN_1 'a'
>+#define BUF_PATTERN_2 'b'
>+
>+static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	unsigned char *buf1;
>+	unsigned char *buf2;
>+	int buf_size = getpagesize() * 3;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf1 = malloc(buf_size);
>+	if (buf1 == NULL) {
>+		perror("'malloc()' for 'buf1'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf2 = malloc(buf_size);
>+	if (buf2 == NULL) {
>+		perror("'malloc()' for 'buf2'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf1, BUF_PATTERN_1, buf_size);
>+	memset(buf2, BUF_PATTERN_2, buf_size);
>+
>+	if (send(fd, buf1, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (send(fd, buf2, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opts)
>+{
>+	int fd;
>+	unsigned char *broken_buf;
>+	unsigned char *valid_buf;
>+	int page_size = getpagesize();
>+	int buf_size = page_size * 3;
>+	ssize_t res;
>+	int prot = PROT_READ | PROT_WRITE;
>+	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>+	int i;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Setup first buffer. */
>+	broken_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+	if (broken_buf == MAP_FAILED) {
>+		perror("mmap for 'broken_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Unmap "hole" in buffer. */
>+	if (munmap(broken_buf + page_size, page_size)) {
>+		perror("'broken_buf' setup");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	valid_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+	if (valid_buf == MAP_FAILED) {
>+		perror("mmap for 'valid_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Try to fill buffer with unmapped middle. */
>+	res = read(fd, broken_buf, buf_size);
>+	if (res != -1) {
>+		fprintf(stderr,
>+			"expected 'broken_buf' read(2) failure, got %zi\n",
>+			res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != ENOMEM) {
>+		perror("unexpected errno of 'broken_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Try to fill valid buffer. */
>+	res = read(fd, valid_buf, buf_size);
>+	if (res < 0) {
>+		perror("unexpected 'valid_buf' read(2) failure");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (res != buf_size) {
>+		fprintf(stderr,
>+			"invalid 'valid_buf' read(2), got %zi, expected %i\n",
>+			res, buf_size);

I would suggest to use always the same pattern in the error messages:
"expected X, got Y".

The rest LGTM.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < buf_size; i++) {
>+		if (valid_buf[i] != BUF_PATTERN_2) {
>+			fprintf(stderr,
>+				"invalid pattern for 'valid_buf' at %i, expected %hhX, got %hhX\n",
>+				i, BUF_PATTERN_2, valid_buf[i]);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+
>+	/* Unmap buffers. */
>+	munmap(broken_buf, page_size);
>+	munmap(broken_buf + page_size * 2, page_size);
>+	munmap(valid_buf, buf_size);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -510,6 +637,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_timeout_client,
> 		.run_server = test_seqpacket_timeout_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET invalid receive buffer",
>+		.run_client = test_seqpacket_invalid_rec_buffer_client,
>+		.run_server = test_seqpacket_invalid_rec_buffer_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1


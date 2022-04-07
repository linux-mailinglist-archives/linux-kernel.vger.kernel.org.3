Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB84F7AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiDGJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiDGJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:08:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A8763B0;
        Thu,  7 Apr 2022 02:06:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED2481F85B;
        Thu,  7 Apr 2022 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649322372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dum3SF0MI6FnOAJY62qBL8AI+owi/9ZpbV05X3S6Rl4=;
        b=xBwZxAqNfyE+iB5/vIqwVf8Wr7grkEWsndIz7kWEBgX7hS+QECEtAhke+FoblsexrQN8oN
        elyFKc3GlecpLwmChy0KyxEnQ5H7x4KwQT0ovYXU07KksK8eCHyA0zZIMHjjWdA7AIu9RE
        upjcxoaNsuIHv7nLvEB2C/8ropF3HQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649322372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dum3SF0MI6FnOAJY62qBL8AI+owi/9ZpbV05X3S6Rl4=;
        b=0YlDnHvi6Mgkx1iaEQmppbm1yU8bxt+u/qxqCjUNCUOUgf7jkl3LHWQ0m+/ZMS6Z/t3HyA
        kBe12Uh169nMfGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9797813A66;
        Thu,  7 Apr 2022 09:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQ7ZIYSpTmLwIAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 09:06:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 02b63267;
        Thu, 7 Apr 2022 09:06:36 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
References: <20220401133243.1075-1-lhenriques@suse.de>
        <cd8418a0-e0dc-c5ae-d49d-6248bb6fc4d6@redhat.com>
Date:   Thu, 07 Apr 2022 10:06:36 +0100
In-Reply-To: <cd8418a0-e0dc-c5ae-d49d-6248bb6fc4d6@redhat.com> (Xiubo Li's
        message of "Thu, 7 Apr 2022 11:19:09 +0800")
Message-ID: <87v8vl8dpf.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiubo Li <xiubli@redhat.com> writes:

> Hi Luis,
>
> Please try the following patch, to see could it resolve your issue:

No, this seems to deadlock when running my test.  I'm attaching the code
I'm using to test it; it's part of generic/647 but I've removed all the
other test cases that were passing.  I simply mount the filesystem with
test_dummy_encryption and run this test.  With your patch it'll hang;
without it it'll show "pwrite (O_DIRECT) is broken".  The extra
invalidate_inode_pages2_range() will make it pass.

Cheers,
--=20
Lu=C3=ADs


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=647.c

// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
 * Written by Andreas Gruenbacher (agruenba@redhat.com)
 */

/* Trigger page faults in the same file during read and write. */

#ifndef _GNU_SOURCE
#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
#endif

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <err.h>

char *filename;
unsigned int page_size;
void *page;
char *addr;
int fd;
ssize_t ret;

/*
 * Leave a hole at the beginning of the test file and initialize a block of
 * @page_size bytes at offset @page_size to @c.  Then, reopen the file and
 * mmap the first two pages.
 */
void init(char c, int flags)
{
	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
	if (fd == -1)
		goto fail;
	memset(page, c, page_size);
	ret = pwrite(fd, page, page_size, page_size);
	if (ret != page_size)
		goto fail;
	if (close(fd))
		goto fail;

	fd = open(filename, flags);
	if (fd == -1)
		goto fail;
	addr = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
	if (addr == MAP_FAILED)
		err(1, NULL);
	return;

fail:
	err(1, "%s", filename);
}

static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
{
	ssize_t count2 = 0, ret;

	do {
		ret = pwrite(fd, buf, count, offset);
		if (ret == -1) {
			if (errno == EINTR)
				continue;
			break;
		}
		if (ret == 0)
			break;
		count2 += ret;
		buf += ret;
		count -= ret;
	} while (count);
	return count2;
}

int main(int argc, char *argv[])
{
	if (argc != 2)
		errx(1, "no test filename argument given");
	filename = argv[1];

	page_size = ret = sysconf(_SC_PAGE_SIZE);
	if (ret == -1)
		err(1, NULL);

	ret = posix_memalign(&page, page_size, page_size);
	if (ret) {
		errno = ENOMEM;
		err(1, NULL);
	}
	init('d', O_RDWR | O_DIRECT);
	ret = do_write(fd, addr + page_size, page_size, 0);
	if (ret != page_size)
		err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
	if (memcmp(addr, page, page_size))
		errx(1, "pwrite (O_DIRECT) is broken");

	if (fsync(fd))
		errx(1, "fsync");
	if (close(fd))
		errx(1, "close");

	if (unlink(filename))
		err(1, "unlink %s", filename);

	return 0;
}

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQo+DQo+DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmlsZS5jDQo+
IGluZGV4IDVkMzlkOGU1NDI3My4uMzUwN2U0MDY2ZGU0IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBo
L2ZpbGUuYw0KPiArKysgYi9mcy9jZXBoL2ZpbGUuYw0KPiBAQCAtMjAxMSw2ICsyMDExLDcgQEAg
c3RhdGljIHNzaXplX3QgY2VwaF9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QN
Cj4gaW92X2l0ZXIgKnRvKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNlcGhfY2FwX3N0cmluZyhnb3QpKTsNCj4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChjaS0+aV9pbmxpbmVfdmVyc2lvbiA9PSBDRVBIX0lOTElORV9OT05FKSB7DQo+
ICsgZmlsZW1hcF9pbnZhbGlkYXRlX2xvY2soaW5vZGUtPmlfbWFwcGluZyk7DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXRyeV9vcCAmJg0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9ESVJFQ1QpICYmDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhSVNfRU5DUllQVEVEKGlub2RlKSkg
ew0KPiBAQCAtMjAyMSw2ICsyMDIyLDcgQEAgc3RhdGljIHNzaXplX3QgY2VwaF9yZWFkX2l0ZXIo
c3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QNCj4gaW92X2l0ZXIgKnRvKQ0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IGNlcGhfc3luY19yZWFkKGlvY2IsIHRvLCAmcmV0cnlfb3ApOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gKyBmaWxlbWFwX2ludmFsaWRh
dGVfdW5sb2NrKGlub2RlLT5pX21hcHBpbmcpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXRyeV9vcCA9IFJFQURfSU5MSU5FOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPiBAQCAtMjIzOSwxMSArMjI0MSwxMyBAQCBzdGF0aWMgc3NpemVfdCBjZXBo
X3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLA0KPiBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20p
DQo+DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiB3ZSBtaWdodCBuZWVkIHRv
IHJldmVydCBiYWNrIHRvIHRoYXQgcG9pbnQgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRhdGEgPSAqZnJvbTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmls
ZW1hcF9pbnZhbGlkYXRlX2xvY2soaW5vZGUtPmlfbWFwcGluZyk7DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoKGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9ESVJFQ1QpICYmICFJ
U19FTkNSWVBURUQoaW5vZGUpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHdyaXR0ZW4gPSBjZXBoX2RpcmVjdF9yZWFkX3dyaXRlKGlvY2IsICZkYXRh
LCBzbmFwYywNCj4gJnByZWFsbG9jX2NmKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVsc2UNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB3cml0dGVuID0gY2VwaF9zeW5jX3dyaXRlKGlvY2IsICZkYXRhLCBwb3MsIHNuYXBjKTsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhp
bm9kZS0+aV9tYXBwaW5nKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChk
aXJlY3RfbG9jaykNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjZXBoX2VuZF9pb19kaXJlY3QoaW5vZGUpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZWxzZQ0KPg0KPg0KPg0KPiBPbiA0LzEvMjIgOTozMiBQTSwgTHXDrXMgSGVucmlx
dWVzIHdyb3RlOg0KPj4gV2hlbiBkb2luZyBESU8gb24gYW4gZW5jcnlwdGVkIG5vZGUsIHdlIG5l
ZWQgdG8gaW52YWxpZGF0ZSB0aGUgcGFnZSBjYWNoZSBpbg0KPj4gdGhlIHJhbmdlIGJlaW5nIHdy
aXR0ZW4gdG8sIG90aGVyd2lzZSB0aGUgY2FjaGUgd2lsbCBpbmNsdWRlIGludmFsaWQgZGF0YS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMdcOtcyBIZW5yaXF1ZXMgPGxoZW5yaXF1ZXNAc3VzZS5k
ZT4NCj4+IC0tLQ0KPj4gICBmcy9jZXBoL2ZpbGUuYyB8IDExICsrKysrKysrKystDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gQ2hh
bmdlcyBzaW5jZSB2MToNCj4+IC0gUmVwbGFjZWQgdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2Uo
KSBieSBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9yYW5nZQ0KPj4gLSBDYWxsIGZzY2FjaGVfaW52
YWxpZGF0ZSB3aXRoIEZTQ0FDSEVfSU5WQUxfRElPX1dSSVRFIGlmIHdlJ3JlIGRvaW5nIERJTw0K
Pj4NCj4+IE5vdGU6IEknbSBub3QgcmVhbGx5IHN1cmUgdGhpcyBsYXN0IGNoYW5nZSBpcyByZXF1
aXJlZCwgaXQgZG9lc24ndCByZWFsbHkNCj4+IGFmZmVjdCBnZW5lcmljLzY0NyByZXN1bHQsIGJ1
dCBzZWVtcyB0byBiZSB0aGUgbW9zdCBjb3JyZWN0Lg0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9j
ZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmlsZS5jDQo+PiBpbmRleCA1MDcyNTcwYzIyMDMuLmIyNzQz
YzM0MjMwNSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2NlcGgvZmlsZS5jDQo+PiArKysgYi9mcy9jZXBo
L2ZpbGUuYw0KPj4gQEAgLTE2MDUsNyArMTYwNSw3IEBAIGNlcGhfc3luY193cml0ZShzdHJ1Y3Qg
a2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSwgbG9mZl90IHBvcywNCj4+ICAgCWlm
IChyZXQgPCAwKQ0KPj4gICAJCXJldHVybiByZXQ7DQo+PiAgIC0JY2VwaF9mc2NhY2hlX2ludmFs
aWRhdGUoaW5vZGUsIGZhbHNlKTsNCj4+ICsJY2VwaF9mc2NhY2hlX2ludmFsaWRhdGUoaW5vZGUs
IChpb2NiLT5raV9mbGFncyAmIElPQ0JfRElSRUNUKSk7DQo+PiAgIAlyZXQgPSBpbnZhbGlkYXRl
X2lub2RlX3BhZ2VzMl9yYW5nZShpbm9kZS0+aV9tYXBwaW5nLA0KPj4gICAJCQkJCSAgICBwb3Mg
Pj4gUEFHRV9TSElGVCwNCj4+ICAgCQkJCQkgICAgKHBvcyArIGNvdW50IC0gMSkgPj4gUEFHRV9T
SElGVCk7DQo+PiBAQCAtMTg5NSw2ICsxODk1LDE1IEBAIGNlcGhfc3luY193cml0ZShzdHJ1Y3Qg
a2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSwgbG9mZl90IHBvcywNCj4+ICAgCQly
ZXEtPnJfaW5vZGUgPSBpbm9kZTsNCj4+ICAgCQlyZXEtPnJfbXRpbWUgPSBtdGltZTsNCj4+ICAg
KwkJaWYgKElTX0VOQ1JZUFRFRChpbm9kZSkgJiYgKGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9ESVJF
Q1QpKSB7DQo+PiArCQkJcmV0ID0gaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2UoDQo+PiAr
CQkJCWlub2RlLT5pX21hcHBpbmcsDQo+PiArCQkJCXdyaXRlX3BvcyA+PiBQQUdFX1NISUZULA0K
Pj4gKwkJCQkod3JpdGVfcG9zICsgd3JpdGVfbGVuIC0gMSkgPj4gUEFHRV9TSElGVCk7DQo+PiAr
CQkJaWYgKHJldCA8IDApDQo+PiArCQkJCWRvdXQoImludmFsaWRhdGVfaW5vZGVfcGFnZXMyX3Jh
bmdlIHJldHVybmVkICVkXG4iLCByZXQpOw0KPj4gKwkJfQ0KPj4gKw0KPj4gICAJCS8qIFNldCB1
cCB0aGUgYXNzZXJ0aW9uICovDQo+PiAgIAkJaWYgKHJtdykgew0KPj4gICAJCQkvKg0KPj4NCj4N
Cg==
--=-=-=--

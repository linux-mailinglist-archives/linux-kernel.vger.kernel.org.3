Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9A5A5935
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH3CP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiH3CP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:15:56 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFE73304;
        Mon, 29 Aug 2022 19:15:55 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 190so10147379vsz.7;
        Mon, 29 Aug 2022 19:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Oj3S4mz1YMZqLTYMLdQERsT0bL7qohRFCPvLzIXkMZQ=;
        b=Ikyv6bOJubYNpo+C1FAItktJeI1UHoFTE9cCOE+S6L2N3M9fcgX6VA0RDr3J7aLUea
         ky5YOmLiYCDwmANn/DzDCycz4gprWbJ5H2mMyt/a1r2pjq8v7479J5rDjINDn6VhYVEv
         o18kFIE/Hsa6NVU99DJ8qXQ0ZFcO8vJ/yQZ4Ww7uejrStRNUQsGQe07gkIjKtkwr/xF3
         4iRVeD5yu3MpKj68cXIxgAOySEdJynmeJ3PQ23xvOEIRnR5RgxpHS/OcEgTXCjMp3V3f
         /g0rJCn2cheWV2BZAkhtfXiyvK4dbbhIjWDaNTiXI1/OVWamtNKH0Xct33vL0QeCYp7i
         fWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Oj3S4mz1YMZqLTYMLdQERsT0bL7qohRFCPvLzIXkMZQ=;
        b=mg5m1N/6oEdKA0bAPiHCAzN9FtUZMgM3ky+Icv8w2TRU/7tuYjSC0kB12887YMlfW4
         F/CrGzYiF/IKP7Am5omno8cqubs5H29ndmk+DDGitveflf/KQe9XsMyIZGNVpMXPRx6f
         ypN1lrPx5mbLZYXbXKxnX9yKxOW5qp0PiYO3vCg4DpZc8Obd4LNSWgur+PCifygDoWYt
         LVUC/KVvQTKTn0XTL+cWRFMUZrHGIVaOdnI3YQVKbiJcvUKIMy3FeA8gbC/NBha1E8IH
         N2hl1DGdpvzfpFQ2f60t38CBaGe+VwqQ3AhdDpAauX0aPH4zXa+FuVKFiW9shHRMm+dT
         owNQ==
X-Gm-Message-State: ACgBeo0cM+x4C5YOc+nChkmn/WOXX2ZTIQdPU9JdM3UZWP8ADR1YrD2I
        lSsXV7ci0ZsRr5FbbSNCdNEA6J9bG6vDXZav0vejO9fBkaUrLA==
X-Google-Smtp-Source: AA6agR59sBMJEFng0G5tKDLfd505T3Z7CG+Vi7pAjb8Sex9HrM2H1ZJuKnpjfmtPFbs+lYew25EQlfbDTObJ4uIPRro=
X-Received: by 2002:a67:b205:0:b0:390:7910:aae6 with SMTP id
 b5-20020a67b205000000b003907910aae6mr4026430vsf.61.1661825754556; Mon, 29 Aug
 2022 19:15:54 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 29 Aug 2022 21:15:43 -0500
Message-ID: <CAH2r5muT-nX+tgk6wm=L1qjWNhc2c5GDBaQXBGbrE-hNkPr3cw@mail.gmail.com>
Subject: [PATCH v2][SMB3 client] smb3: use filemap_write_and_wait_range
 instead of filemap_write_and_wait
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: multipart/mixed; boundary="000000000000c7807f05e76bf543"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c7807f05e76bf543
Content-Type: text/plain; charset="UTF-8"

When doing insert range and collapse range we should be
writing out the cached pages for the ranges affected but not
the whole file (and also checking for errors if writing them out
fails)

See attached

-- 
Thanks,

Steve

--000000000000c7807f05e76bf543
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-use-filemap_write_and_wait_range-instead-of-fil.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-use-filemap_write_and_wait_range-instead-of-fil.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l7fk486b0>
X-Attachment-Id: f_l7fk486b0

RnJvbSA5MGNhMDhiM2VlNjlmMTVjNWE2ZTNkOGQ3NmQ1MTZkOGYwM2NjZjE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMjkgQXVnIDIwMjIgMTE6NTM6NDEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiB1c2UgZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZSBpbnN0ZWFkIG9mCiBmaWxlbWFw
X3dyaXRlX2FuZF93YWl0CgpXaGVuIGRvaW5nIGluc2VydCByYW5nZSBhbmQgY29sbGFwc2UgcmFu
Z2Ugd2Ugc2hvdWxkIGJlCndyaXRpbmcgb3V0IHRoZSBjYWNoZWQgcGFnZXMgZm9yIHRoZSByYW5n
ZXMgYWZmZWN0ZWQgYnV0IG5vdAp0aGUgd2hvbGUgZmlsZS4KCkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNv
bT4KLS0tCiBmcy9jaWZzL2NpZnNmcy5jICB8ICA4ICsrKysrKy0tCiBmcy9jaWZzL3NtYjJvcHMu
YyB8IDEzICsrKysrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNmcy5jIGIvZnMvY2lmcy9j
aWZzZnMuYwppbmRleCBlOWZiMzM4YjhlN2UuLjgwNDJkNzI4MGRlYyAxMDA2NDQKLS0tIGEvZnMv
Y2lmcy9jaWZzZnMuYworKysgYi9mcy9jaWZzL2NpZnNmcy5jCkBAIC0xMjE5LDggKzEyMTksNiBA
QCBzc2l6ZV90IGNpZnNfZmlsZV9jb3B5Y2h1bmtfcmFuZ2UodW5zaWduZWQgaW50IHhpZCwKIAog
CWNpZnNfZGJnKEZZSSwgImNvcHljaHVuayByYW5nZVxuIik7CiAKLQlmaWxlbWFwX3dyaXRlX2Fu
ZF93YWl0KHNyY19pbm9kZS0+aV9tYXBwaW5nKTsKLQogCWlmICghc3JjX2ZpbGUtPnByaXZhdGVf
ZGF0YSB8fCAhZHN0X2ZpbGUtPnByaXZhdGVfZGF0YSkgewogCQlyYyA9IC1FQkFERjsKIAkJY2lm
c19kYmcoVkZTLCAibWlzc2luZyBjaWZzRmlsZUluZm8gb24gY29weSByYW5nZSBzcmMgZmlsZVxu
Iik7CkBAIC0xMjUwLDYgKzEyNDgsMTIgQEAgc3NpemVfdCBjaWZzX2ZpbGVfY29weWNodW5rX3Jh
bmdlKHVuc2lnbmVkIGludCB4aWQsCiAJbG9ja190d29fbm9uZGlyZWN0b3JpZXModGFyZ2V0X2lu
b2RlLCBzcmNfaW5vZGUpOwogCiAJY2lmc19kYmcoRllJLCAiYWJvdXQgdG8gZmx1c2ggcGFnZXNc
biIpOworCisJcmMgPSBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlKHNyY19pbm9kZS0+aV9t
YXBwaW5nLCBvZmYsCisJCQkJCSAgb2ZmICsgbGVuIC0gMSk7CisJaWYgKHJjKQorCQlnb3RvIG91
dDsKKwogCS8qIHNob3VsZCB3ZSBmbHVzaCBmaXJzdCBhbmQgbGFzdCBwYWdlIGZpcnN0ICovCiAJ
dHJ1bmNhdGVfaW5vZGVfcGFnZXMoJnRhcmdldF9pbm9kZS0+aV9kYXRhLCAwKTsKIApkaWZmIC0t
Z2l0IGEvZnMvY2lmcy9zbWIyb3BzLmMgYi9mcy9jaWZzL3NtYjJvcHMuYwppbmRleCA3Yzk0MWNl
MWU3YTkuLmYxZDM2YjcwY2VmNyAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIyb3BzLmMKKysrIGIv
ZnMvY2lmcy9zbWIyb3BzLmMKQEAgLTM2ODcsNyArMzY4NywxMCBAQCBzdGF0aWMgbG9uZyBzbWIz
X2NvbGxhcHNlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29u
LAogCX0KIAogCWZpbGVtYXBfaW52YWxpZGF0ZV9sb2NrKGlub2RlLT5pX21hcHBpbmcpOwotCWZp
bGVtYXBfd3JpdGVfYW5kX3dhaXQoaW5vZGUtPmlfbWFwcGluZyk7CisJcmMgPSBmaWxlbWFwX3dy
aXRlX2FuZF93YWl0X3JhbmdlKGlub2RlLT5pX21hcHBpbmcsIG9mZiwgb2xkX2VvZiAtIDEpOwor
CWlmIChyYyA8IDApCisJCWdvdG8gb3V0XzI7CisKIAl0cnVuY2F0ZV9wYWdlY2FjaGVfcmFuZ2Uo
aW5vZGUsIG9mZiwgb2xkX2VvZik7CiAKIAlyYyA9IHNtYjJfY29weWNodW5rX3JhbmdlKHhpZCwg
Y2ZpbGUsIGNmaWxlLCBvZmYgKyBsZW4sCkBAIC0zNzA4LDcgKzM3MTEsNyBAQCBzdGF0aWMgbG9u
ZyBzbWIzX2NvbGxhcHNlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgY2lmc190Y29u
ICp0Y29uLAogCWZzY2FjaGVfcmVzaXplX2Nvb2tpZShjaWZzX2lub2RlX2Nvb2tpZShpbm9kZSks
IGNpZnNpLT5zZXJ2ZXJfZW9mKTsKIG91dF8yOgogCWZpbGVtYXBfaW52YWxpZGF0ZV91bmxvY2so
aW5vZGUtPmlfbWFwcGluZyk7Ci0gb3V0Ogorb3V0OgogCWlub2RlX3VubG9jayhpbm9kZSk7CiAJ
ZnJlZV94aWQoeGlkKTsKIAlyZXR1cm4gcmM7CkBAIC0zNzM4LDcgKzM3NDEsOSBAQCBzdGF0aWMg
bG9uZyBzbWIzX2luc2VydF9yYW5nZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGNpZnNfdGNv
biAqdGNvbiwKIAllb2YgPSBjcHVfdG9fbGU2NChvbGRfZW9mICsgbGVuKTsKIAogCWZpbGVtYXBf
aW52YWxpZGF0ZV9sb2NrKGlub2RlLT5pX21hcHBpbmcpOwotCWZpbGVtYXBfd3JpdGVfYW5kX3dh
aXQoaW5vZGUtPmlfbWFwcGluZyk7CisJcmMgPSBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3Jhbmdl
KGlub2RlLT5pX21hcHBpbmcsIG9mZiwgb2xkX2VvZiArIGxlbiAtIDEpOworCWlmIChyYyA8IDAp
CisJCWdvdG8gb3V0XzI7CiAJdHJ1bmNhdGVfcGFnZWNhY2hlX3JhbmdlKGlub2RlLCBvZmYsIG9s
ZF9lb2YpOwogCiAJcmMgPSBTTUIyX3NldF9lb2YoeGlkLCB0Y29uLCBjZmlsZS0+ZmlkLnBlcnNp
c3RlbnRfZmlkLApAQCAtMzc1Nyw3ICszNzYyLDcgQEAgc3RhdGljIGxvbmcgc21iM19pbnNlcnRf
cmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJcmMgPSAw
Owogb3V0XzI6CiAJZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhpbm9kZS0+aV9tYXBwaW5nKTsK
LSBvdXQ6CitvdXQ6CiAJaW5vZGVfdW5sb2NrKGlub2RlKTsKIAlmcmVlX3hpZCh4aWQpOwogCXJl
dHVybiByYzsKLS0gCjIuMzQuMQoK
--000000000000c7807f05e76bf543--

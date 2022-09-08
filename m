Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F365B1238
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIHBzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIHBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:55:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5025299
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:55:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 130so18646101ybz.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date;
        bh=f3FVyDagMbu4/t709XgA6UIISAASxFuNGu2n5xDzxVc=;
        b=C7Lh/pvPURleQ+IEP1X5+h1MdXx5ODZXRKvti11CImKo/LZ9D9zNCWuhd726NwuQcc
         6GS0cZJmzMTa26O2fjbtpv6mQYIfYLNqQ9QfkETPYnwjA++gS7mowbki4VT+xMGRX/Sn
         qtrb6d+/m4+qaHxby+pEmiMgwC14yjlStUp2LDq795aBU5lpLAPJuJkk5lsnnZQkdYmH
         iHxmZjpaYiV/VwowFOz0dj6BxD3335I+lXfGccGnQI8PzxNqEug1iI3oxxh+ZEN2HJr3
         HeGIhdtgSvVRFbanM54m22wEKbKca7zTvu1B9K9DSr7ZJbIcwGAlSgPNYFeOMWDgUQDn
         Ds2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f3FVyDagMbu4/t709XgA6UIISAASxFuNGu2n5xDzxVc=;
        b=2DephFkga2ZpU9scIrB3rqxwdhvYtx43y820Ndeo6pHEkK4+DiZfRyHhRVglFfijaR
         kHlCNbZBVeHln0CxSI0POrF6wCKP47ob/2BFenN1k8l8wX+PP7UdKH3aMmcJiajUYzY3
         23k5aFe4EAVPikoLz8XhweLuJS5Dn55ZUBXjhQi8W4XFBKiD7MXkdsZsZyewvKp5ZTBb
         mhotY4nnEzwT8axI0bq67vdu1IObBXHIfgUInoRcxdpYZEi2imxtNR1Pe+VS4KfwVt/J
         0FI71zUhv93BLX8DlkXMSrwgWVzFvd0ZmZS4bSMvpwz1s+YjuQbJiC0CbTeXc3Uu/LHv
         4C4A==
X-Gm-Message-State: ACgBeo3qU0XGoFrD+5sW+W4bSc3xOKGFBT7kBJpVwzDcSOYVymHI3pl0
        HguRq3RzNFSy4qMPM/6ZoBGlzmHIFitBfDaDDUY=
X-Google-Smtp-Source: AA6agR79fYoucAdmMfPLebAMG46AyM6qpB5eWJ+5vqpnW8RXKoDnXFvS5tIX2qCUqh4QwmRxwG40KJdOQFkEYG5FL20=
X-Received: by 2002:a05:6902:154d:b0:6a9:7aa7:e17b with SMTP id
 r13-20020a056902154d00b006a97aa7e17bmr1032680ybu.170.1662602100799; Wed, 07
 Sep 2022 18:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:80ab:0:0:0:0 with HTTP; Wed, 7 Sep 2022 18:54:59
 -0700 (PDT)
In-Reply-To: <hh8rmxiims.fsf@jvdspc.jvds.net>
References: <hh8rmxiims.fsf@jvdspc.jvds.net>
From:   Jason Vas Dias <jason.vas.dias@gmail.com>
Date:   Thu, 8 Sep 2022 02:54:59 +0100
Message-ID: <CALyZvKyFQfPFj-Dqy7ep+MzAv=LdwG+1meQOesbAL=8E3EffZA@mail.gmail.com>
Subject: Re: SIGIO with si_code==POLL_HUP on read pipe FD with no writers?
To:     Jason Vas Dias <jason.vas.dias@ptt.ie>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009f48d605e820b734"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009f48d605e820b734
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I raised bug https://bugzilla.kernel.org/show_bug.cgi?id=3D216458
about this and submitted this patch, which I have tested by
incorporating into the Fedora 36 kernel.spec file build, which
I updated to v5.19.7.

Now, my test program runs fine and the whole Fedora subsystem & GUI
comes up OK under the patched kernel
 - so it appears I have not broken anything so far -
I will test more thoroughly with any kernel / POSIX / I/O
test suites I can find tomorrow - can anyone recommend any ?

The patch certainly does not break any POSIX rules AFAICS ,
(rather it tries to honor the ones concerning SIGIO & POLL_HUP,
 as described in the latest linux & POSIX manual pages, better ).

I can post the RPMs to my google drive account & share them
if anyone is interested .

Please review kernel bug 216458 & consider including this patch
in a future kernel release - it works well, causes no harm, and
makes I/O programming with SIGIO & pipes much more robust
and straightforward.

Thanks, Best Regards,
Jason Vas Dias

On 05/09/2022, Jason Vas Dias <jason.vas.dias@ptt.ie> wrote:
>
> Good day -
>
>     To the last committer & maintainers of 'linux/fs/pipe.c' :
>
>     Why isn't a SIGIO signal with POLL_HUP in 'si_code'
>     raised on an O_ASYNC, F_SETOWN{,_EX} pid F_SETSIG
>     signal owning pipe read file descriptor ?
>
>     All that happens when the write end of a pipe is
>     closed is that a SIGIO gets raised with the
>     (struct siginfo* parameter)->si_code set
>     to 1 ( POLL_IN ) , and then
>      ioctl( fd, FIONREAD, &sz)
>     then returns with sz=3D=3D0 for that fd ;
>     a read() on that fd would then return 0.
>
>     Looking at pipe.c, the situation of no pipe writers
>     is detected and revents is set to contain EPOLLHUP
>     ONLY in pipe_poll(), not pipe_read() .
>
>     pipe_read() (in version 5.19) DOES detect the
>     no writers situation :
>
>     fs/pipe.c, @line 255:
> 	for (;;) {
> 		/* Read ->head with a barrier vs post_one_notification() */
>         ...
>     @line 341:
> 		if (!pipe->writers)
> 			break;
>         ...
>
>     It would be quite easy to add after the pipe_read() loop quits a clau=
se
> as in
>     pipe_poll() , @ line 677:
> 	mask =3D 0;
> 	if (filp->f_mode & FMODE_READ) {
> 		if (!pipe_empty(head, tail))
> 			mask |=3D EPOLLIN | EPOLLRDNORM;
> 		if (!pipe->writers && filp->f_version !=3D pipe->w_counter)
> 			mask |=3D EPOLLHUP;
> 	}
>
>     which does something like :
>
> 	if ( !pipe->writers )
> 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_HUP);
>
>
>     It is not nice to have to GUESS that just because
>         ioctl(fd, FIONREAD, &sz)
>     returns with sz=3D=3D0 immediately after a POLL_IN event,
>     that the pipe in fact has no writers, because the
>     signal could be blocked when the ioctl call happens.
>
>     And if one happens not to try to read 0 bytes from the pipe,
>     then one would never know that no writers exist on it, and
>     could pause() infinitely waiting for a signal.
>     Or why should I have to put the FD into O_NONBLOCK mode
>     (which mine was not in) and attempt a read to return
>     0 bytes, when I know 0 bytes are available to read ?
>
>     OR, maybe in pipe_write(), @ line 595 where it does :
>
>     	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>
>     (which is probably where the FINAL POLL_IN signal originates)
>     it could instead do:
>         kill_fasync(&pipe->fasync_readers, SIGIO,
>                     ((ret=3D=3D0) && (pipe->fasync_writers <=3D 1))
>                     ? POLL_HUP
>                     : POLL_IN
>                    );
>
>      It seems there are several easy ways to fix this and
>      I believe that it would make processes wanting to
>      read pipes using SIGIO much more robust & simple to code.
>
>      Processes would still be able to rely on read()s returning
>      0 in this case, but please, why can't SIGIO using processes
>      also get a definitive SIGIO with si_code=3D=3DPOLL_HUP, not POLL_IN =
?
>
>      There appears to be similar logic that does send
>      a final POLL_HUP SIGIO when the remote write end of
>      a readable socket closes - why not for pipes ?
>
>      And the sigaction manual page states:
>      "
>        The  following values can be placed in si_code for a SIGIO/SIGPOLL
> sig=E2=80=90
>        nal:
>
>            POLL_IN
>                   Data input available.
>
>            POLL_OUT
>                   Output buffers available.
>
>            POLL_MSG
>                   Input message available.
>
>            POLL_ERR
>                   I/O error.
>
>            POLL_PRI
>                   High priority input available.
>
>            POLL_HUP
>                   Device disconnected.
>      "
>      which suggests that these events should be raised for all devices -
>      it does not mention any special cases for pipe file descriptors,
>      so readers would reasonably expect a POLL_HUP event to be sent
>      on a read end of a pipe with no writers.
>
>      Please do something about this -
>      or would a patch from me that fixes this ever be
>      likely to be considered ?
>
> Thanks for any responses & Best Regards,
> Jason Vas Dias
>
>
>
>
>
>
>

--0000000000009f48d605e820b734
Content-Type: text/x-patch; charset="US-ASCII"; name="fs_pipe_c_pipe_fd_sigio_poll_hup.patch"
Content-Disposition: attachment; 
	filename="fs_pipe_c_pipe_fd_sigio_poll_hup.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtdXAgbGludXgtNS4xOS43LTIwMC5mYzM2Lng4Nl82NC9mcy9waXBlLmMucGlwZV9mZF9z
aWdpb19wb2xsX2h1cCBsaW51eC01LjE5LjctMjAwLmZjMzYueDg2XzY0L2ZzL3BpcGUuYwotLS0g
bGludXgtNS4xOS43LTIwMC5mYzM2Lng4Nl82NC9mcy9waXBlLmMucGlwZV9mZF9zaWdpb19wb2xs
X2h1cAkyMDIyLTA5LTA1IDA5OjMxOjM2LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtNS4xOS43
LTIwMC5mYzM2Lng4Nl82NC9mcy9waXBlLmMJMjAyMi0wOS0wNyAyMTowOToxNC4wNzUyMDQ0NTkg
KzAxMDAKQEAgLTIzMyw3ICsyMzMsNyBAQCBwaXBlX3JlYWQoc3RydWN0IGtpb2NiICppb2NiLCBz
dHJ1Y3QgaW92CiAJc2l6ZV90IHRvdGFsX2xlbiA9IGlvdl9pdGVyX2NvdW50KHRvKTsKIAlzdHJ1
Y3QgZmlsZSAqZmlscCA9IGlvY2ItPmtpX2ZpbHA7CiAJc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAq
cGlwZSA9IGZpbHAtPnByaXZhdGVfZGF0YTsKLQlib29sIHdhc19mdWxsLCB3YWtlX25leHRfcmVh
ZGVyID0gZmFsc2U7CisJYm9vbCB3YXNfZnVsbCwgZW1wdHksIHdha2VfbmV4dF9yZWFkZXIgPSBm
YWxzZTsKIAlzc2l6ZV90IHJldDsKIAogCS8qIE51bGwgcmVhZCBzdWNjZWVkcy4gKi8KQEAgLTM4
MiwxMCArMzgyLDE1IEBAIHBpcGVfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3YK
IAkJd2FzX2Z1bGwgPSBwaXBlX2Z1bGwocGlwZS0+aGVhZCwgcGlwZS0+dGFpbCwgcGlwZS0+bWF4
X3VzYWdlKTsKIAkJd2FrZV9uZXh0X3JlYWRlciA9IHRydWU7CiAJfQotCWlmIChwaXBlX2VtcHR5
KHBpcGUtPmhlYWQsIHBpcGUtPnRhaWwpKQorCisJaWYgKChlbXB0eSA9IHBpcGVfZW1wdHkocGlw
ZS0+aGVhZCwgcGlwZS0+dGFpbCkpKQogCQl3YWtlX25leHRfcmVhZGVyID0gZmFsc2U7CisKIAlf
X3BpcGVfdW5sb2NrKHBpcGUpOwogCisJaWYgKCBlbXB0eSAmJiBwaXBlLT5mYXN5bmNfcmVhZGVy
cyAmJiAhcGlwZS0+d3JpdGVycyApCisJCWtpbGxfZmFzeW5jKCZwaXBlLT5mYXN5bmNfcmVhZGVy
cywgU0lHSU8sIFBPTExfSFVQKTsKKwogCWlmICh3YXNfZnVsbCkKIAkJd2FrZV91cF9pbnRlcnJ1
cHRpYmxlX3N5bmNfcG9sbCgmcGlwZS0+d3Jfd2FpdCwgRVBPTExPVVQgfCBFUE9MTFdSTk9STSk7
CiAJaWYgKHdha2VfbmV4dF9yZWFkZXIpCkBAIC01OTIsNyArNTk3LDE1IEBAIG91dDoKIAkgKi8K
IAlpZiAod2FzX2VtcHR5IHx8IHBpcGUtPnBvbGxfdXNhZ2UpCiAJCXdha2VfdXBfaW50ZXJydXB0
aWJsZV9zeW5jX3BvbGwoJnBpcGUtPnJkX3dhaXQsIEVQT0xMSU4gfCBFUE9MTFJETk9STSk7Ci0J
a2lsbF9mYXN5bmMoJnBpcGUtPmZhc3luY19yZWFkZXJzLCBTSUdJTywgUE9MTF9JTik7CisKKwlp
ZiAocGlwZS0+ZmFzeW5jX3JlYWRlcnMgKQorCXsKKwkJaWYgKHJldCA+IDApCisJCQlraWxsX2Zh
c3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lPLCBQT0xMX0lOKTsKKwkJZWxzZSBpZiAo
IXBpcGUtPndyaXRlcnMpCisJCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJ
R0lPLCBQT0xMX0hVUCk7CisJfQorCiAJaWYgKHdha2VfbmV4dF93cml0ZXIpCiAJCXdha2VfdXBf
aW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUtPndyX3dhaXQsIEVQT0xMT1VUIHwgRVBPTExX
Uk5PUk0pOwogCWlmIChyZXQgPiAwICYmIHNiX3N0YXJ0X3dyaXRlX3RyeWxvY2soZmlsZV9pbm9k
ZShmaWxwKS0+aV9zYikpIHsKQEAgLTcxNSw2ICs3MjgsNyBAQCBzdGF0aWMgaW50CiBwaXBlX3Jl
bGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiB7CiAJc3RydWN0
IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKwl1bnNpZ25lZCBp
bnQgaGVhZCwgdGFpbDsKIAogCV9fcGlwZV9sb2NrKHBpcGUpOwogCWlmIChmaWxlLT5mX21vZGUg
JiBGTU9ERV9SRUFEKQpAQCAtNzI2LDggKzc0MCwxNiBAQCBwaXBlX3JlbGVhc2Uoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0CiAJaWYgKCFwaXBlLT5yZWFkZXJzICE9ICFwaXBlLT53cml0ZXJz
KSB7CiAJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoJnBpcGUtPnJkX3dhaXQpOwogCQl3YWtl
X3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT53cl93YWl0KTsKLQkJa2lsbF9mYXN5bmMoJnBp
cGUtPmZhc3luY19yZWFkZXJzLCBTSUdJTywgUE9MTF9JTik7Ci0JCWtpbGxfZmFzeW5jKCZwaXBl
LT5mYXN5bmNfd3JpdGVycywgU0lHSU8sIFBPTExfT1VUKTsKKwkJaGVhZCA9IFJFQURfT05DRShw
aXBlLT5oZWFkKTsKKwkJdGFpbCA9IFJFQURfT05DRShwaXBlLT50YWlsKTsKKwkJaWYgKCBwaXBl
X2VtcHR5KGhlYWQsdGFpbCkgICYmICFwaXBlLT53cml0ZXJzICkKKwkJCWtpbGxfZmFzeW5jKCZw
aXBlLT5mYXN5bmNfcmVhZGVycywgU0lHSU8sIFBPTExfSFVQKTsKKwkJZWxzZSBpZiAocGlwZS0+
ZmFzeW5jX3JlYWRlcnMpCisJCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJ
R0lPLCBQT0xMX0lOKTsKKwkJaWYgKCAoIXBpcGUtPnJlYWRlcnMpICYmIHBpcGUtPmZhc3luY193
cml0ZXJzKQorCQkJa2lsbF9mYXN5bmMoJnBpcGUtPmZhc3luY193cml0ZXJzLCBTSUdJTywgUE9M
TF9IVVApOworCQllbHNlIGlmIChwaXBlLT5mYXN5bmNfd3JpdGVycykKKwkJCWtpbGxfZmFzeW5j
KCZwaXBlLT5mYXN5bmNfd3JpdGVycywgU0lHSU8sIFBPTExfT1VUKTsKIAl9CiAJX19waXBlX3Vu
bG9jayhwaXBlKTsKIAo=
--0000000000009f48d605e820b734--

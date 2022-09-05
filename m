Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D15ADB12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIEWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEWDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:03:30 -0400
Received: from mail-wm1-x363.google.com (mail-wm1-x363.google.com [IPv6:2a00:1450:4864:20::363])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3046275C0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:03:28 -0700 (PDT)
Received: by mail-wm1-x363.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso6372043wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ptt-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:reply-to:cc
         :subject:to:from:from:to:cc:subject:date;
        bh=Py2m2oTxzbBxRqJ2++cgbUo9iTBf41/OVDpXTx6j4Js=;
        b=hkqSrW0Thrl0ZGo+7XXONUX8hcOegoNvWaAJvARuUNy4aODtL29AmdizosYf0UQjv/
         J8A8tm9cm2cbFc1Zp0CmBiNcapNcYJKfAgBCiDFzcWDfyAbH4lV9prrfA0fndZ4mCPev
         FfLOfs7zLjKnVhxLwtT3yOYEgzZtPDImYBSKM1Tu0W+uioQQvrPBxwv0J6himW7iP+fB
         62uWafZ41F/NkORAze0jvA+5nPMeu2H83MkwMluMttbosDywehuj36grOv4k0MsAvjJx
         XrpW/RIl7ZSi88viAmBT46y7T8RE55G84nNOQEmnV3mQiwYjTA1P0VPSDsnjeolO0M9m
         RQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:reply-to:cc
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Py2m2oTxzbBxRqJ2++cgbUo9iTBf41/OVDpXTx6j4Js=;
        b=x+e7LBuSN2dGKtBoMKiKC3u2iXtJ+qTfWssK/gUFIDYZZ5+N5zWPlZc/OnHAwN1l1O
         DysAjTR9LRKzPpkdh6VW8cntNAAUP1hAOAh8uHAcLiYHd2zcU/Pg066JXQw4qHb9OCl2
         wxfUvDinFBiL/lz7TRgJ3OIDjYYHV2xZg3hiasmH1hnKvfQy/UvoLghj47m1YfTtUwaK
         bx6EniPBnQoWdtLfxWFMyrGmiedJZ9fUXIljQiAuFtwboEo9ICJtW8BpGvMfRJBj9Qva
         MajKsqYXWHTZrSCq7rO227RnYlgYBX4QeB6AOuBBJLw6rsLHIQrfVr7eqh46LIxoAKzj
         HIdg==
X-Gm-Message-State: ACgBeo1LndPJ9I3inUj48OaF4d6XyiVo/d93IfvgWecZfXwkl7vR41pO
        7CppKAweEdgsNbxN06mq70drgTzkdah5Mi++dQAYwHrZCA8O3g==
X-Google-Smtp-Source: AA6agR7Gt6Rjo41fy/lpDE5z7iR98RXDi1T5WvccpFs0kmZSA3a2T5+zrlv3W9CzjoVbMnpD2t3aLxVgvvIN
X-Received: by 2002:a05:600c:354a:b0:3a5:b01b:2ab0 with SMTP id i10-20020a05600c354a00b003a5b01b2ab0mr11587471wmq.61.1662415406087;
        Mon, 05 Sep 2022 15:03:26 -0700 (PDT)
Received: from jvdspc.jvds.net ([212.129.82.86])
        by smtp-relay.gmail.com with ESMTPS id t14-20020a05600c128e00b003a64a1afe7esm442963wmd.43.2022.09.05.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:03:26 -0700 (PDT)
X-Relaying-Domain: ptt.ie
Received: from jvdspc.jvds.net (localhost.localdomain [127.0.0.1])
        by jvdspc.jvds.net (8.17.1/8.17.1) with ESMTPS id 285M3OgA228056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 5 Sep 2022 23:03:24 +0100
Received: (from jvd@localhost)
        by jvdspc.jvds.net (8.17.1/8.17.1/Submit) id 285M3NKf228055;
        Mon, 5 Sep 2022 23:03:23 +0100
From:   "Jason Vas Dias" <jason.vas.dias@ptt.ie>
To:     David Howells <dhowells@redhat.com>
Subject: SIGIO with si_code==POLL_HUP on read pipe FD with no writers? 
cc:     linux-kernel@vger.kernel.org, jason.vas.dias@gmail.com
Reply-To: "Jason Vas Dias" <jason.vas.dias@ptt.ie>
Date:   Mon, 05 Sep 2022 23:03:23 +0100
Message-ID: <hh8rmxiims.fsf@jvdspc.jvds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good day -

    To the last committer & maintainers of 'linux/fs/pipe.c' :

    Why isn't a SIGIO signal with POLL_HUP in 'si_code'
    raised on an O_ASYNC, F_SETOWN{,_EX} pid F_SETSIG
    signal owning pipe read file descriptor ?

    All that happens when the write end of a pipe is
    closed is that a SIGIO gets raised with the
    (struct siginfo* parameter)->si_code set
    to 1 ( POLL_IN ) , and then=20
     ioctl( fd, FIONREAD, &sz)
    then returns with sz=3D=3D0 for that fd ;
    a read() on that fd would then return 0.

    Looking at pipe.c, the situation of no pipe writers
    is detected and revents is set to contain EPOLLHUP
    ONLY in pipe_poll(), not pipe_read() .

    pipe_read() (in version 5.19) DOES detect the
    no writers situation :

    fs/pipe.c, @line 255:
	for (;;) {
		/* Read ->head with a barrier vs post_one_notification() */
        ...
    @line 341:
		if (!pipe->writers)
			break;
        ...

    It would be quite easy to add after the pipe_read() loop quits a clause=
 as in
    pipe_poll() , @ line 677:
	mask =3D 0;
	if (filp->f_mode & FMODE_READ) {
		if (!pipe_empty(head, tail))
			mask |=3D EPOLLIN | EPOLLRDNORM;
		if (!pipe->writers && filp->f_version !=3D pipe->w_counter)
			mask |=3D EPOLLHUP;
	}
=20=20=20
    which does something like :

	if ( !pipe->writers )
		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_HUP);

=20=20=20=20
    It is not nice to have to GUESS that just because=20
        ioctl(fd, FIONREAD, &sz)=20
    returns with sz=3D=3D0 immediately after a POLL_IN event,
    that the pipe in fact has no writers, because the
    signal could be blocked when the ioctl call happens.

    And if one happens not to try to read 0 bytes from the pipe,
    then one would never know that no writers exist on it, and
    could pause() infinitely waiting for a signal.
    Or why should I have to put the FD into O_NONBLOCK mode
    (which mine was not in) and attempt a read to return
    0 bytes, when I know 0 bytes are available to read ?
=20=20=20=20
    OR, maybe in pipe_write(), @ line 595 where it does :

    	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
=20=20=20=20=20=20=20=20
    (which is probably where the FINAL POLL_IN signal originates)=20=20=20=
=20=20
    it could instead do:
        kill_fasync(&pipe->fasync_readers, SIGIO,=20
                    ((ret=3D=3D0) && (pipe->fasync_writers <=3D 1))
                    ? POLL_HUP
                    : POLL_IN
                   );

     It seems there are several easy ways to fix this and
     I believe that it would make processes wanting to
     read pipes using SIGIO much more robust & simple to code.

     Processes would still be able to rely on read()s returning
     0 in this case, but please, why can't SIGIO using processes
     also get a definitive SIGIO with si_code=3D=3DPOLL_HUP, not POLL_IN ?

     There appears to be similar logic that does send
     a final POLL_HUP SIGIO when the remote write end of
     a readable socket closes - why not for pipes ?

     And the sigaction manual page states:
     "
       The  following values can be placed in si_code for a SIGIO/SIGPOLL s=
ig=E2=80=90
       nal:

           POLL_IN
                  Data input available.

           POLL_OUT
                  Output buffers available.

           POLL_MSG
                  Input message available.

           POLL_ERR
                  I/O error.

           POLL_PRI
                  High priority input available.

           POLL_HUP
                  Device disconnected.
     "
     which suggests that these events should be raised for all devices -
     it does not mention any special cases for pipe file descriptors,
     so readers would reasonably expect a POLL_HUP event to be sent
     on a read end of a pipe with no writers.
=20
     Please do something about this -=20
     or would a patch from me that fixes this ever be
     likely to be considered ?

Thanks for any responses & Best Regards,
Jason Vas Dias

=20=20=20=20=20
=20=20=20=20
=20=20=20=20=20=20=20=20=20=20

=20=20=20=20

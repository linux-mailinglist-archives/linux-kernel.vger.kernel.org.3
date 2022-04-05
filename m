Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C44F4EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1589154AbiDFASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350074AbiDEJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:52:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3F4889C;
        Tue,  5 Apr 2022 02:50:42 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 961E91EC03D2;
        Tue,  5 Apr 2022 11:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649152237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DH5S/er9X11ZTTBEd8YblMTm3IG7JzpUoyr29PRpMNs=;
        b=VIf0HM2jX1YdtVb5hTAEgk5DFZTyEuqB0Pr2VtXo15eB3Lg0QQ7MuRjsaRQs136zI4aywp
        bSprUvF1W0ywkt8M/DAHxjVwZ+OtKoJp/xTcidpsqD7LVltVOQHQBZxqKj78+xD2NEhT1J
        QCKGfo65e4Bz0Y2TF92Xu4qJHDWsF9A=
Date:   Tue, 5 Apr 2022 11:50:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-toolchains@vger.kernel.org
Cc:     Michael Matz <matz@suse.de>, Richard Biener <rguenther@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: older gccs and case labels producing integer constants
Message-ID: <YkwQ6+tIH8GQpuct@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm starting to see failures like this on allmodconfig builds:

sound/usb/midi.c: In function ‘snd_usbmidi_out_endpoint_create’:
sound/usb/midi.c:1389:2: error: case label does not reduce to an integer constant
  case (((0xfc08) << 16) | (0x0101)):
  ^~~~

(The case statement is a macro but it evaluates to what I have there)

and that thing fails with

$ gcc --version
gcc (SUSE Linux) 7.5.0

although it doesn't have any problems building with newer compilers.

I'm presuming older gccs consider those case statements signed ints and
the following fixes it:

  case ((((unsigned int)0xfc08) << 16) | (0x0101)):

and I guess we can whack the couple of occurrences but what I'm
wondering is why does this work with newer gccs?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C625946FE5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhLJKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:04:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbhLJKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:04:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 048971F3A1;
        Fri, 10 Dec 2021 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639130454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ul+ABzZ41ukEAiazH3jaH2jdypjmeOVGz0JMsInLYyw=;
        b=DXBbv0lZLFNyORI+qqBbqxIl6CSOnWfqZgn3S/KD7VCpIzZSpwM8PGWiNDlf/1XoA4R9EF
        O4+Gv9PLEqCOIDJSVNc7d0NapM32wfzssyWaxPkz6wfbwVUbg2mW9zRQlIOuEA7Xs5TlHf
        wQsex5bZ0Fa8y4DvOIRZncODHsUXMpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639130454;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ul+ABzZ41ukEAiazH3jaH2jdypjmeOVGz0JMsInLYyw=;
        b=s36vKVoJbkxIzvMQmUQTGsHnwI41C5jiOswOx9Dqv1PWQWeyxadHuP9Kf2S1trGTupWQ2D
        649xe8Uk2z74BtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77DB413C1D;
        Fri, 10 Dec 2021 10:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yGYcG1Uls2F8QwAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 10 Dec 2021 10:00:53 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 00/18] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
References: <20211209090358.28231-1-nstange@suse.de>
        <3288406.bErb3Tvseg@tauon.chronox.de>
Date:   Fri, 10 Dec 2021 11:00:52 +0100
In-Reply-To: <3288406.bErb3Tvseg@tauon.chronox.de> (Stephan Mueller's message
        of "Fri, 10 Dec 2021 08:56:44 +0100")
Message-ID: <877dccdbjf.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan Mueller <smueller@chronox.de> writes:

> Am Donnerstag, 9. Dezember 2021, 10:03:40 CET schrieb Nicolai Stange:
>
> I successfully tested the entire patch set with the NIST ACVP reference=20
> implementation which covers key generation for all safe prime groups defi=
ned=20
> in your patch set.
>
> Tested-by: Stephan Mueller <smueller@chronox.de>

Thank you!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev

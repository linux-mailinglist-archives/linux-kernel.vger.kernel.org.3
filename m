Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F547290F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbhLMKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:17:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbhLMKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:12:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC08A1F3BA;
        Mon, 13 Dec 2021 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639390333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNx1zR1/Fgli6BcXKjYqn4bJ2J/OPNdQFzUAIa8NmyE=;
        b=0J/vMt/v6XkwCvfxE0NAQav/yMfYnF4C8ClGrKDW3xjYjK3aX6+R5CkyTWs8JLhRp9Nct+
        q0AEcCJJq0FxLi/Ama8K0kZQrm/D3E/N7hmXVKdYXOyxMOssVPwT1+URPlDJyzOtTWkQEi
        q9C7VSywNjsjzMEMw6uCx8yZhkv3YPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639390333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNx1zR1/Fgli6BcXKjYqn4bJ2J/OPNdQFzUAIa8NmyE=;
        b=5Yn4+sr7mgXf55O1QMlKDpLuYVvzLGMnWbXSrvWaErNfSoM1DNRZrmz/mvthjMmrCjheZV
        Au6SlfP1bAgO1CBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 296F813CE5;
        Mon, 13 Dec 2021 10:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1hkoCH0ct2GvNwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 13 Dec 2021 10:12:13 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 00/18] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
References: <20211209090358.28231-1-nstange@suse.de>
        <aabe44df-0b6c-8550-0138-b08f90ef9233@suse.de>
Date:   Mon, 13 Dec 2021 11:12:12 +0100
In-Reply-To: <aabe44df-0b6c-8550-0138-b08f90ef9233@suse.de> (Hannes Reinecke's
        message of "Fri, 10 Dec 2021 12:38:31 +0100")
Message-ID: <87ee6greyr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> I have run this implementation against my NVMe In-band authentication
> test suite and have found no issues.
>
> Tested-by: Hannes Reinecke <hare@suse.de>

Thank you!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev

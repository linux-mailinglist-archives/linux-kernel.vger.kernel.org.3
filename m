Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71F2476758
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhLPBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:14:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ACEC061574;
        Wed, 15 Dec 2021 17:14:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F6BAB8226B;
        Thu, 16 Dec 2021 01:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC8C36AE3;
        Thu, 16 Dec 2021 01:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639617278;
        bh=7PNDRZJ4FbAVuHjGSTVy+l4yWgjIoYFTFZdR4hDgoqc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=n6+Eu11oVtWPj4FndZxqhf2r3AegHuwckCYwjrLiKemrQrttqenJzXVsUrPYOLTyB
         lUShMxsFYqp1dc2PJuoEgdCvxDodqUgBEvKnBOMlL2E2/VDOfN++5ifte5NEVykHoM
         2I0lzoyWYvL3jBoBDTk1EzcJzV8r/zn9YlQ4wectmSkwwUQoXglpInUaPsNpHQPqQo
         X97OJ6pluiKrP8IRrA9KUh4J/BhEUAOGpua2L7W+qR9gFFHS0tFsE6HCRRuTcWQFF3
         viLq+BKkQMz3GRCLEdJAf3VwEX0N3s4x+TyrcLNkgSxNboQJ9f//FA+dCes6pDpGWN
         hdSWy6zCUTTAw==
Received: by mail-oi1-f173.google.com with SMTP id q25so34306437oiw.0;
        Wed, 15 Dec 2021 17:14:37 -0800 (PST)
X-Gm-Message-State: AOAM532FwMGqsJu1dJ4iPG0oY7ClqsgsAw4Ry3K1U25zBPiaf5YJmrqs
        Xql7GDA8sNg+e6fKpJYgp5sKWW+u1zTJzLXleC8=
X-Google-Smtp-Source: ABdhPJxm0JeQTmsX1Ge9ZJeaUSWSnRjuqWebegLGsOj1aQTLNLzLJo/0ZjqC/uoKtnAyPNjCeAmM1Z2/tcbK2kx2c64=
X-Received: by 2002:a05:6808:a8f:: with SMTP id q15mr2281978oij.65.1639617277171;
 Wed, 15 Dec 2021 17:14:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Wed, 15 Dec 2021 17:14:36
 -0800 (PST)
In-Reply-To: <20211216003119.1609352-1-marcos@orca.pet>
References: <20211216003119.1609352-1-marcos@orca.pet>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Dec 2021 10:14:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-r14FNB-jKfCS+v69dgjxPBNdm109jRQ7BKxngN_qWTg@mail.gmail.com>
Message-ID: <CAKYAXd-r14FNB-jKfCS+v69dgjxPBNdm109jRQ7BKxngN_qWTg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-16 9:31 GMT+09:00, Marcos Del Sol Vives <marcos@orca.pet>:
> According to the official Microsoft MS-SMB2 document section 3.3.5.4, this
> flag should be used only for 3.0 and 3.0.2 dialects. Setting it for 3.1.1
> is a violation of the specification.
>
> This causes my Windows 10 client to detect an anomaly in the negotiation,
> and disable encryption entirely despite being explicitly enabled in ksmbd,
> causing all data transfers to go in plain text.
>
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
> Cc: linux-kernel@vger.kernel.org
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ksmbd/smb2ops.c |  3 ---
>  fs/ksmbd/smb2pdu.c | 25 +++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
> index 0a5d8450e835..02a44d28bdaf 100644
> --- a/fs/ksmbd/smb2ops.c
> +++ b/fs/ksmbd/smb2ops.c
> @@ -271,9 +271,6 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
>  	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
>  		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
>
> -	if (conn->cipher_type)
> -		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
> -
>  	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
>  		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 49c9da37315c..6193d5a1d653 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -915,6 +915,25 @@ static void decode_encrypt_ctxt(struct ksmbd_conn
> *conn,
>  	}
>  }
>
> +/**
> + * should_encrypt() - checks if connection should be encrypted
> + * @conn:	smb connection
> + *
> + * Return:	true if should be encrypted, else false
> + */
> +static bool should_encrypt(struct ksmbd_conn *conn)
Can you change function name to smb3_encryption_negotiated() ?
And need to update function description also.

Thanks for your patch!
> +{
> +	if (!conn->ops->generate_encryptionkey)
> +		return false;
> +
> +	/*
> +	 * SMB 3.0 and 3.0.2 dialects use the SMB2_GLOBAL_CAP_ENCRYPTION flag.
> +	 * SMB 3.1.1 uses the cipher_type field.
> +	 */
> +	return (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) ||
> +	    conn->cipher_type;
> +}
> +
>  static void decode_compress_ctxt(struct ksmbd_conn *conn,
>  				 struct smb2_compression_capabilities_context *pneg_ctxt)
>  {
> @@ -1469,8 +1488,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
>  		    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
>  			sess->sign = true;
>
> -		if (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION &&
> -		    conn->ops->generate_encryptionkey &&
> +		if (should_encrypt(conn) &&
>  		    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
>  			rc = conn->ops->generate_encryptionkey(sess);
>  			if (rc) {
> @@ -1559,8 +1577,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
>  	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
>  		sess->sign = true;
>
> -	if ((conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) &&
> -	    conn->ops->generate_encryptionkey) {
> +	if (should_encrypt(conn)) {
>  		retval = conn->ops->generate_encryptionkey(sess);
>  		if (retval) {
>  			ksmbd_debug(SMB,
> --
> 2.25.1
>
>

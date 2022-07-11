Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3A5708B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiGKRO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 960685140C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657559692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35DqiAZ6Rz9bU45GAwcR4RKA7a4vhTM0nhoXy16hhhQ=;
        b=eW/IwLJQ+z7Ykkiawqao8mw5Y6szEirO28cVe6thFJJMnjSecLEsJlX3Vso/wQvjxsuLkN
        UPKDv6YC/FDhnFRoNkSkEJQYp2XwCGk79pvKrAdl4naCxgcrTzkgbCgD+VrdnvH/z31PmN
        rb3QN+BTYkVcLK0R0zxjfh6juxkBizM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-LaRfEAZFNH2QG_PgoSIp3w-1; Mon, 11 Jul 2022 13:14:51 -0400
X-MC-Unique: LaRfEAZFNH2QG_PgoSIp3w-1
Received: by mail-ed1-f72.google.com with SMTP id h17-20020a056402281100b0043aa5c0493dso4582809ede.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35DqiAZ6Rz9bU45GAwcR4RKA7a4vhTM0nhoXy16hhhQ=;
        b=GrEpMViiNUon/+o+gbY8ZUQXYubRRAEzWcL+Gz9nW+WyoDfeIj0FDUbjLxmQCDFJgO
         qxzuYAEPexdQox5dJYY0nFzYuTI2GQpVFS5Ef99kzrF9TZ5AmM7P3kd5SG/klagCTY4D
         6seBG9N2HAwEUKGRYDpT67bWcxhQoWAeL7cLaQRLesgeB04wTrnwNvHoulI76xlO/zFK
         q+c0RU3/qMiR+E7h9gXQOlHJXndgyyEkA4JIWe9BOVCQ+4uaSVDGzLNUakJDzTTWkbhN
         Va2poi1zs/8QwESHtdrOS24M7Ez5Jb1HwFXuu/w/2ZgtrEAjqr6MSma7seblkgPltVIr
         j88Q==
X-Gm-Message-State: AJIora9JO84CmiZd37TDPi4xnw6gi1waBpsvmns6+9qDJIZIaZ8+gbLY
        f/SJs4fG8RYukpEztXvNeCZEx7ra11FLgKqlbwM6VCQK3nHWaN7QTlB/w9pFC/rUcJcQT21zc3j
        tM/vz/M1+6GdZrufPAH8OeXHK
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id zd7-20020a17090698c700b0072b20fe807dmr20024454ejb.75.1657559689853;
        Mon, 11 Jul 2022 10:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9ZWTo7LZGXSyJRODCmNvfVx0G0jU4xWGbua1KvPEwjej7JxnKJiwXOn4I8RodSYxpIdnXhA==
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id zd7-20020a17090698c700b0072b20fe807dmr20024434ejb.75.1657559689637;
        Mon, 11 Jul 2022 10:14:49 -0700 (PDT)
Received: from localhost ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906814300b0072ab06bf296sm2840101ejw.23.2022.07.11.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:14:49 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:14:47 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Message-ID: <20220711191447.1046538c@redhat.com>
In-Reply-To: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2022 14:46:04 -0400
Chuck Lever <chuck.lever@oracle.com> wrote:

> NFSD has advertised support for the NFSv4 time_create attribute
> since commit e377a3e698fb ("nfsd: Add support for the birth time
> attribute").
> 
> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
> birth time attribute via OPEN(CREATE) and SETATTR if the server
> indicates that it supports it, but since the above commit was
> merged, those attempts now fail.
> 
> Table 5 in RFC 8881 lists the time_create attribute as one that can
> be both set and retrieved, but the above commit did not add server
> support for clients to provide a time_create attribute. IMO that's
> a bug in our implementation of the NFSv4 protocol, which this commit
> addresses.
> 
> Whether NFSD silently ignores the new birth time or actually sets it
> is another matter. I haven't found another filesystem service in the
> Linux kernel that enables users or clients to modify a file's birth
> time attribute.
> 
> This commit reflects my (perhaps incorrect) understanding of whether
> Linux users can set a file's birth time. NFSD will now recognize a
> time_create attribute but it ignores its value. It clears the
> time_create bit in the returned attribute bitmask to indicate that
> the value was not used.
> 
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Thanks for fixing it,
tested 'touch', 'cp', 'tar' within CLI and copying file with Finder

Tested-by: Igor Mammedov <imammedo@redhat.com>


on tangent:
when copying file from Mac (used 'cp') there is a delay ~4sec/file
'cp' does first triggers create then extra open and then setattr
which returns
   SETATTR Status: NFS4ERR_DELAY
after which the client stalls for a few seconds before repeating setattr.
So question is what makes server unhappy to trigger this error
and if it could be fixed on server side.

it seems to affect other methods of copying. So if one extracted
an archive with multiple files or copied multiple files, that
would be a pain.

With vers=3 copying is 'instant'
with linux client and vers=4.0 copying is 'instant' as well but it
doesn't use the same call sequence.

PS:
it is not regression (I think slowness was there for a long time)

> ---
>  fs/nfsd/nfs4xdr.c |    9 +++++++++
>  fs/nfsd/nfsd.h    |    3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 61b2aae81abb..2acea7792bb2 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>  			return nfserr_bad_xdr;
>  		}
>  	}
> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
> +		struct timespec64 ts;
> +
> +		/* No Linux filesystem supports setting this attribute. */
> +		bmval[1] &= ~FATTR4_WORD1_TIME_CREATE;
> +		status = nfsd4_decode_nfstime4(argp, &ts);
> +		if (status)
> +			return status;
> +	}
>  	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
>  		u32 set_it;
>  
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 847b482155ae..9a8b09afc173 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>  	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
>  #define NFSD_WRITEABLE_ATTRS_WORD1 \
>  	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
> +	| FATTR4_WORD1_TIME_MODIFY_SET)
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>  	FATTR4_WORD2_SECURITY_LABEL
> 
> 


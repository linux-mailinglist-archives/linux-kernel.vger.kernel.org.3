Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8644DD8E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiCRLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCRLaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB10D196085
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647602935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jX3XcNdW+Ax9nZGkwRj/4ZIncJ0ly8t/9orHLyMptgc=;
        b=fbxIwifT9ET7B9zcS9QhJULmzHM3+V9N9UveF4ZSGBZTnzjIscm/l2G1UJhYoppbFlsx2b
        oBqE1EKBMmB2NHFEsCy+CZN9VAhWMTeiaTBBDXH1ruJRcr/obXZ4jIi/5UeZFuDbFTBjK4
        Slvw8d5bYawlz2SQKb563XIvR6LcWZc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-nmC6w9XLN8qyKIuT47_BWw-1; Fri, 18 Mar 2022 07:28:54 -0400
X-MC-Unique: nmC6w9XLN8qyKIuT47_BWw-1
Received: by mail-pg1-f198.google.com with SMTP id l6-20020a637006000000b003811a27370aso3258421pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jX3XcNdW+Ax9nZGkwRj/4ZIncJ0ly8t/9orHLyMptgc=;
        b=MCfmsO5J1bpsXjDmAw9FtJLYWUap/ZLd+qrEGwV7iPhI+cdvx9HGmgqetv3++f2p2z
         tU8T20hggbvwo52AfnbdxM7/XUjVi+DDsFhGE0BVZaNe+A+vd8I6U0mXspOX4qjx0RXs
         Gf30niXdQaFIl2/M3x8vvAh7oZNXG4chnLnpgHU+mT0SWz7EgtDY39nmw6gMwT+2sI6G
         nAVt/BSkudWbrc1LGP4/wfFtVohIW0O8OtiN6eWvtLlp+ZZhh8N53F81O524F7lDey/Z
         7QPPvLbAjGz0m0rMI8R+Pu3AkzrsUG3+PteOKhV2qUqdtGtkHo9tk6szvEhMrJdEwwtV
         aeZw==
X-Gm-Message-State: AOAM5302wTBy+eeMK/Fnu9RGsNuwd/Jeux9+Od+jp9T2XCIgZ0LhBtWY
        msjNy74t4PshlCyM+g9WjxCgJDOYoPAaYj+U4XOoB3sQcNEXEVB6bOc7KgQJbhUeHCDKdIEoAdW
        tsmGy/CHENBuPhTK/maIpTWpIIqWdWPZvyyup2NV5+NmnZ6GVW3q9BDmOhpF6xDRnQ8bG3a37LQ
        ==
X-Received: by 2002:a17:902:ec87:b0:153:ddac:a9f2 with SMTP id x7-20020a170902ec8700b00153ddaca9f2mr9486779plg.56.1647602932385;
        Fri, 18 Mar 2022 04:28:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3meKt4wUJ69S8mlWYgwFLoBQHJRuKlnH3Qa5bj9JyLzKv94L7Ztpcg4Gr2Syw2hJhdYLR1A==
X-Received: by 2002:a17:902:ec87:b0:153:ddac:a9f2 with SMTP id x7-20020a170902ec8700b00153ddaca9f2mr9486758plg.56.1647602932035;
        Fri, 18 Mar 2022 04:28:52 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z11-20020a056a001d8b00b004f74f8268cbsm7967126pfw.85.2022.03.18.04.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:28:51 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/4] ceph: handle encrypted snapshot names in
 subdirectories
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220317154521.6615-1-lhenriques@suse.de>
 <20220317154521.6615-3-lhenriques@suse.de>
 <61d831de-1589-3a19-8f46-a162099e75df@redhat.com>
 <878rt7h6qs.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <15c60a74-73a9-a509-2b0e-2d9c6bfd9398@redhat.com>
Date:   Fri, 18 Mar 2022 19:28:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <878rt7h6qs.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/22 6:53 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 3/17/22 11:45 PM, Luís Henriques wrote:
>>> When creating a snapshot, the .snap directories for every subdirectory will
>>> show the snapshot name in the "long format":
>>>
>>>     # mkdir .snap/my-snap
>>>     # ls my-dir/.snap/
>>>     _my-snap_1099511627782
>>>
>>> Encrypted snapshots will need to be able to handle these snapshot names by
>>> encrypting/decrypting only the snapshot part of the string ('my-snap').
>>>
>>> Also, since the MDS prevents snapshot names to be bigger than 240 characters
>>> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
>>> limitation.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/crypto.c | 189 ++++++++++++++++++++++++++++++++++++++++-------
>>>    fs/ceph/crypto.h |  11 ++-
>>>    2 files changed, 169 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>> index beb73bbdd868..caa9863dee93 100644
>>> --- a/fs/ceph/crypto.c
>>> +++ b/fs/ceph/crypto.c
>>> @@ -128,16 +128,100 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
>>>    	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>>    }
>>>    -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr
>>> *d_name, char *buf)
>>> +/*
>>> + * User-created snapshots can't start with '_'.  Snapshots that start with this
>>> + * character are special (hint: there aren't real snapshots) and use the
>>> + * following format:
>>> + *
>>> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
>>> + *
>>> + * where:
>>> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decrypted,
>>> + *  - <INODE-NUMBER> - the inode number for the actual snapshot
>>> + *
>>> + * This function parses these snapshot names and returns the inode
>>> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
>>> + * length.
>>> + */
>>> +static struct inode *parse_longname(const struct inode *parent, const char *name,
>>> +				    int *name_len)
>>>    {
>>> +	struct inode *dir = NULL;
>>> +	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
>>> +	char *inode_number;
>>> +	char *name_end;
>>> +	int orig_len = *name_len;
>>> +	int ret = -EIO;
>>> +
>>> +	/* Skip initial '_' */
>>> +	name++;
>>> +	name_end = strrchr(name, '_');
>>> +	if (!name_end) {
>>> +		dout("Failed to parse long snapshot name: %s\n", name);
>>> +		return ERR_PTR(-EIO);
>>> +	}
>>> +	*name_len = (name_end - name);
>>> +	if (*name_len <= 0) {
>>> +		pr_err("Failed to parse long snapshot name\n");
>>> +		return ERR_PTR(-EIO);
>>> +	}
>>> +
>>> +	/* Get the inode number */
>>> +	inode_number = kmemdup_nul(name_end + 1,
>>> +				   orig_len - *name_len - 2,
>>> +				   GFP_KERNEL);
>>> +	if (!inode_number)
>>> +		return ERR_PTR(-ENOMEM);
>>> +	ret = kstrtou64(inode_number, 0, &vino.ino);
>>> +	if (ret) {
>>> +		dout("Failed to parse inode number: %s\n", name);
>>> +		dir = ERR_PTR(ret);
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* And finally the inode */
>>> +	dir = ceph_find_inode(parent->i_sb, vino);
>>> +	if (!dir) {
>>> +		/* This can happen if we're not mounting cephfs on the root */
>>> +		dir = ceph_get_inode(parent->i_sb, vino, NULL);
>> In this case IMO you should lookup the inode from MDS instead create it in the
>> cache, which won't setup the encryption info needed.
>>
>> So later when you try to use this to dencrypt the snapshot names, you will hit
>> errors ? And also the case Jeff mentioned in previous thread could happen.
> No, I don't see any errors.  The reason is that if we get a I_NEW inode,
> we do not have the keys to even decrypt the names.  If you mount a
> filesystem using as root a directory that is inside an encrypted
> directory, you'll see the encrypted snapshot name:
>
>   # mkdir mydir
>   # fscrypt encrypt mydir
>   # mkdir -p mydir/a/b/c/d
>   # mkdir mydir/a/.snap/myspan
>   # umount ...
>   # mount <mon>:<port>:/a
>   # ls .snap
>
> And we simply can't decrypt it because for that we'd need to have access
> to the .fscrypt in the original filesystem mount root.

Should we resolve this issue ? Something like try to copy the .fscrypt 
when mounting '/a' ?

-- Xiubo


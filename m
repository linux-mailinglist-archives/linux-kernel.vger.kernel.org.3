Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D44519705
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbiEDFrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEDFrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:47:23 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7726112;
        Tue,  3 May 2022 22:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=TatprxO4xZzU4ESyGnkidUF+o4GoftI+QmBq5qqUcsk=; b=XFBowGi34o1WrJgRi8WIGJb6Xf
        z4i5namwqTAY6ynnqw6+qyOLfpof0m1jFPULcaHDe2qwps9gntBlaaWi/DPMTlOj/b+9CaPYJh0LE
        NImUPO3O9FJ3oDvG/RP3aFIYmJoC3GrhkPjyuj+Bcl4q01L8Eaewif7dX5tVUCX+C6bo5PX+xqsqE
        Ngy/fm+pegLfkDLIENYThIw0b2zlnFgjGFex033aJACY0tnNDl9DdURaRnm78To35TK4M+vsqd4Rn
        QwvkZFC9PGg2uK0F9qAjOlaEGXHhhY48OSbZUb0QeR1nEly/jMalCfMyFEkhDpspOamNiTX0k1ZuX
        8Wxuuxe/LaX2lS7wAgdo8JEJ3Ush3rel8qwz/COwRogyTHtCSdPwbUyhThktUFsRCckss7KDowuNa
        PY1WHXF2r0BA9A50ZKwL513eqEiQuU2zcH4McVbI3pSAcJtmVHg7o097JfwFoe8GRaCBBBJVei1OE
        +INE1IHAFkOGhRJ3zINWpB61;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1nm7nd-0041Oj-8c; Wed, 04 May 2022 05:43:45 +0000
Message-ID: <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
Date:   Wed, 4 May 2022 00:43:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
Content-Language: en-US
To:     Paulo Alcantara <pc@cjr.nz>, Byron Stanoszek <gandalf@winds.org>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz>
From:   Steven French <sfrench@samba.org>
In-Reply-To: <878rri2i6o.fsf@cjr.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

makes sense - do you see anything related in the NTLMSSP doc?

Want to spin up a patch for SMB1 for this?

On 5/3/22 20:35, Paulo Alcantara wrote:
> Byron Stanoszek <gandalf@winds.org> writes:
>
>> I would like to report a regression in the CIFS fs. Sometime between Linux 4.14
>> and 5.16, mounting CIFS with option vers=1.0 (and
>> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y set appropriately) with security type
>> NTLMSSP stopped working for me. The server side is a Windows 2003 Server.
>>
>> I found that this behavior depends on the length of the Linux client's
>> host+domain name (e.g. utsname()->nodename), where the mount works as long as
>> the name is 16 characters or less. Anything 17 or above returns -EIO, per the
>> following example:
> Looks like your server is expecting the WorkstationName field in
> AUTHENTICATE_MESSAGE payload to be 16 bytes long.  That is, NetBIOS name
> length as per rfc1001.
>
>> I implemented a workaround using the following patch:
>>
>> Signed-off-by: Byron Stanoszek <gandalf@winds.org>
>> ---
>> --- a/fs/cifs/cifsglob.h
>> +++ b/fs/cifs/cifsglob.h
>> @@ -101,7 +101,7 @@
>>    #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
>>    #endif
>>
>> -#define CIFS_MAX_WORKSTATION_LEN  (__NEW_UTS_LEN + 1)  /* reasonable max for client */
>> +#define CIFS_MAX_WORKSTATION_LEN 16
>>
>>    /*
>>     * CIFS vfs client Status information (based on what we know.)
>>
>> I don't know if this patch is correct or will have any real effect outside of
>> the NTLMSSP session connect sequence, but it worked in my case.
> Perhaps we should be use TCP_Server_Info::workstation_RFC1001_name in
> fs/cifs/sess.c:build_ntlmssp_auth_blob() instead only when connecting to
> old servers by using insecure dialects -- like SMB1, in your case.

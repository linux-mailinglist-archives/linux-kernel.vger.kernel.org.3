Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF74AF7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiBIRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBIRTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:19:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85969C0613C9;
        Wed,  9 Feb 2022 09:19:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 151A11F45BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644427147;
        bh=EmS/W1EI/bFaHyrZs8Qcocq8P6UYCEQANTMzviQjeMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Da36hj26GW19pbpEb9hY62xmjG4MGPXiVIkPvXs6PGiRcBL8jkbG+xHa61ieuNlGq
         UH5Z2kVCPXBLCKVaEYscBHQEVk6RGqYtLrcJQMIzk67Fe9zU6/a/sH+4aXGsezWiDm
         sbRymvOUJHcr+tJ8UXpcSKboskGy8QmiRNByqVHWgJN66n01esVPJIo91hNJSiao5i
         ioJdHWS/eHR0OOr7ffjFmoc/kt8DrVEhfC0ialSxKgqUVGeU1GnVatx5GycJoL+K3J
         dzMNSZT5Z2tAxNzpCP4j2A/KxFyZxLqPLPWhB8PxBDTWlw3Gprgku2oYif/FNFKjaT
         Q0DRZYBsWla6A==
Message-ID: <2126f6c0-fd6e-1f8e-b450-837270d03d31@collabora.com>
Date:   Wed, 9 Feb 2022 14:18:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] spi: amd: Add support for version AMDI0062
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20220209165733.43134-1-andrealmeid@collabora.com>
 <20220209165733.43134-4-andrealmeid@collabora.com>
 <YgP2fIbASQym9sUP@sirena.org.uk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <YgP2fIbASQym9sUP@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 14:14 de 09/02/22, Mark Brown escreveu:
> On Wed, Feb 09, 2022 at 01:57:33PM -0300, André Almeida wrote:
> 
>> @@ -190,6 +237,9 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>>  	message->actual_length = tx_len + rx_len + 1;
>>  	/* complete the transaction */
>>  	message->status = 0;
>> +
>> +	if (amd_spi->version == AMD_SPI_V2)
>> +		amd_spi_clear_chip(amd_spi, message->spi->chip_select);
>>  	spi_finalize_current_message(master);
>>  
>>  	return 0;
> 
> Why is this one not a switch statement - what happens with v3?

A switch statement should work as well, but currently v1 does nothing
and there's no v3 for now. I think we can change for a switch if v3
requires to do something here as well.

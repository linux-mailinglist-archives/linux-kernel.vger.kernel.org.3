Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA4473751
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhLMWQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:16:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55852 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234248AbhLMWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:16:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLLhSi005519;
        Mon, 13 Dec 2021 22:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gCMt9q3rzDwYM5Xc5SJp7Hpht6I6DgvClgnKpzyuUZI=;
 b=RdKdc7IipOkCdasLV6mpTcJkcso5OGO7q730cMvq0e7J5DMOEnZnhXySTLOoizojwmQU
 uR02g8w+woH5wZ/XE3OYsUPveLQUpIJzQYZBMPKd4n83XkzUR/G25UgoVXzPoDx22hU6
 4dLxVgHNTRnWm5WnQ+lZTqIWvPXMmldwC/lyEAvO22UPHrPpAM013rvT+lGyE0NGI3xW
 HCH6r8Xtah9q4JOnlqy6pXmHh30ygfA0ci6ybchnv3FewdfyNT0J9EG50wo7UxG4XpOF
 6eEOpHNkQswWjrxNHph2oLOSgZ4gXU+OIg+eRHWG9cnZxznaf9WOBGoVGdc52XPcVVWX xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u1tq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:16:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDMBXaE101008;
        Mon, 13 Dec 2021 22:16:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3cvh3w7dkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTK7/J0n+en/AqeLAV2Bn0G7BmVkjZae6NwjTRB38vt6TkW3OZUdg5sapF7kLtNe3vnHLHrjquELoqLBLS0Qt2ik7SOtJBHqB2r5WHwx+5LKHU3uJnElSinZ2F9xKFOOfmk86Vj6FbHEb6P3yYhuvTzaXlKD8ZGcQFfteQqAniBJ73evniG92QR8fyiDFq7RUU5722aF2V1fTr7qaDHvM15+Gc0OXjCJ6CqM4aNK0ChjtxVrkEXjIaMMYXlOupsCY5e5+/BPz/lNa/G22L1b5czWxOzL+jQcm48JJi9slO+hcac1IrzxXJ5kL3ZEbh1qBLwiCa74obt/3tsMNNj/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCMt9q3rzDwYM5Xc5SJp7Hpht6I6DgvClgnKpzyuUZI=;
 b=HyQfhKzpcbESi6Wc820rSNEYQyL4/qqySm53t2DkcdFHLBq8962y8Xxp9jTIu34J36i8+wprLMLoAzarhc044S39LCYQKsS310UCk+M6s9vZQTGQk4E9AdfZyCR5LbT0bSobt/j8T/hneUsv7cB1z1Ef8a1IORCbbA3H9RsrSmm7LEHmCzaPyYZ52oQtTuvqWw9Daxem8JXe8g51rAQ9TlNwEX+cfFix7fxOdjF5y4Wpp1Z2/itjJB5Emf4MjZMiha8Fv0/jDTUMrLImJJWpgFkNhp3YVfv0UbhwbSBVM4ImSDG6/8FOpznTXUiXiuWRIOHK3fWw7tK5K17hwmJnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCMt9q3rzDwYM5Xc5SJp7Hpht6I6DgvClgnKpzyuUZI=;
 b=qAWndi5hR336hWj1y3nZrE7iQ0QC9GR7yKdb8B8JLFouZ+cpHEcUm1kUVx0++qf2KaEp5NQVHv/YqhfUIIuMhfyQbLzXU7+unVh198STBBOGOw0zFJ/gD8h338odR2uooMtPbiBpljhFbE/5pQXbOkaTCgoZ0V8cQ+MjBSZ+HPQ=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN8PR10MB3730.namprd10.prod.outlook.com (2603:10b6:408:b6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:16:02 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:16:01 +0000
Message-ID: <e3ff85bc-bf01-c90d-298f-4cbd30b460c1@oracle.com>
Date:   Mon, 13 Dec 2021 17:15:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH RESEND 2] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
 <c6212443-e40a-2813-1920-905e89884204@opensource.wdc.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c6212443-e40a-2813-1920-905e89884204@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65af6175-bf7a-411a-6686-08d9be862586
X-MS-TrafficTypeDiagnostic: BN8PR10MB3730:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB37304C235B1C92F3212DBBFDE6749@BN8PR10MB3730.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gePBaUUc4PID+gMMm7uok/mODGhSr64APO6uTrao9f8wiHXn36vCTteeXMFZ13wwSWH8CuJaLk2OmYNPZ2FZpcYeBLD3xL/LY8hBeuKuse+XIZ/XbjZbd0fA0S0b5/mb8SfUpU1GnNiCcLvKsKyqcfQXLZbAOHCAbmZOycQBRverbEKjwlNWfKuHCy2gJM8IMzItXTxAwCjJDBfBOrMWpgGKBYV/CO7Om4krtp5qFzKR//139KL+Vl7EookkoNHSbfTpsnp5qJFScO9KPN/hNwVkfDKCo3R+XZkuTa7dVmH65GtXE9POYSv6DXtHNBwtTKSfx+pQ5T/gbClXRScb82KhAUCox5bms2uRE/XSELuM3aCOlUePNdKzLsYTDTHUyXqZRx/prKzywUaJQEuI5tYXyKUn+jfuY1cnOx3rWAXRFd9caEJ6EDB+yz0VX6N0NrcQtoS6epKW4XEyf9rn1RvP4EwhZXujyuWisK3LI7tmIkFrHz1eD7lCg2ySyu3I+PWunv3oexy40hNUX1NkHDHDIFgmw9zvFHgns7ryg9dU+Y8Yi/YRIhd5XJ7mMksrDXYY0QoprGecV2FifHcdYN72M4LLmD+ySuD4Xhv4SaSKC5IXBRsGDQYWRcyTYk0YWPUdhVI+XBlYjPfNw1GOgVMDKYBd9DhbDCgAcrcc6cZaj4NO6c6PfOp06vf1ulO+WsU0Er87FqZbuiZtbIySbVxcH1I2hi+KkvVXQRNf2m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(53546011)(8676002)(6512007)(38100700002)(186003)(2616005)(44832011)(36916002)(316002)(8936002)(508600001)(31686004)(6486002)(6916009)(26005)(66476007)(6666004)(4326008)(5660300002)(86362001)(66556008)(2906002)(36756003)(66946007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9sbWc4dUpkUGFhYTczV0lpR1FHZzNXbzM2MnI1b0pEbU1hY0d6bld6OVpm?=
 =?utf-8?B?M0FxUU1wVTY4V3JJckh3OCtzSkFJZTJlRVViSVgrOUVhWFcvVDczODRKenc3?=
 =?utf-8?B?QmUxYUFRTldxS1Zlb3laS2FvRnA5RnNvYmxBMkVFeWhFRkJ0WjllRUppdVlu?=
 =?utf-8?B?NTIxZlNzdU1IV0hJWUtoSWtKVDJlVlc5T1QwSldhWDBrNjVDQ21ya2JEZGR6?=
 =?utf-8?B?ejdsYUt5Yzg4cjlGQ2FoY0p0WGtaVG9tTC9KN29pQ3pyVUwxZm5YOXJGSXVT?=
 =?utf-8?B?clN5RWVRRGRiUitpS284U2ZGVzJJUHNqNGdoN2VtU3NQRXN3bFFKTC9XT3RX?=
 =?utf-8?B?d1QrZk5wcFNTaEduK1JmZEk1QVFqNXAyRWxSY1JPV2xaeWIwdG92aGNsTmRv?=
 =?utf-8?B?R1dOOFZxTmlYWk5PT25QTGw2U3NpOGNHbWhJeWw3MWxCeWlCVEczaS8rQUZo?=
 =?utf-8?B?ZEZmQ0ZCajYvRHZZZFF3RlhJZUp6ZkVGVklFOGc4MlBUcEpJSUJ0eWdqcFhO?=
 =?utf-8?B?TSsyY3M3V05GNGI5eElpcEJPOFd6a0RqYjMrSlNmc1dVYnp3bWEwbTlSRFN3?=
 =?utf-8?B?ZXQ3RTRzTWt0SldDLzVycFdVZ1RSS1l6ZmRPS3hsYkppTGtYNUJVWXpnT3Ux?=
 =?utf-8?B?SFAwZGcxWmtyd1k3VDY2dDVwNERIY2ZQQ01PeHNCZTVaVjkrUkhuRll6Um53?=
 =?utf-8?B?c1VVV2pNcXhBYW5xejRIaGhqd0VXQzIzRHp1V1lBWG9pdnBMWW1Qd21PTVpa?=
 =?utf-8?B?eSttOE5Jc3lIZGtWdlRnRGJrb29jbnlTNlNISkQzMmdETnlrcDZaYUovZmNG?=
 =?utf-8?B?UjQ0R1Z5cDVYbVdRVVdpOU1aeWFscGNyeituRUpLMnhUZ3pNWXBhZE40cmFi?=
 =?utf-8?B?Q2NIanh6UVBsSzY1WjhPQkExZXZIbmhiTWpFRjBDbHF0SFlrVlRwQnNvOTFY?=
 =?utf-8?B?SEZLeTBUOCtZalU2dU1oN0pSWnd0Z0o2NTFYc3Fycnc4V2hmRTN2bmxRcmg0?=
 =?utf-8?B?QTFEcm9UU0N5YXpaazNwWmlzKzZ1TGxHUnVySHJ5NnFEaHVtNWFTVm9QU3hy?=
 =?utf-8?B?WDVkTWRManZtTkZPeXlJNGFieTZsTHlYNXRpQmFMMHZLVlRKSXB5bG95amVz?=
 =?utf-8?B?WXd5dloyUDlxSHBKRTZscHFYUVkzSVBLZDRmOUtsRllJR2JTbHlQTWgvak1r?=
 =?utf-8?B?d0IrT3lONkFqcnFUREh3Y0p4cDZpNlhVcXR4NnZPOFpVL0dHN3poMC9kb0NQ?=
 =?utf-8?B?clVxNW5rSytHcW9OU0JKazNnekNUWWQwWCt0b2ZqeEZuNnFSWGliS2NrSnJx?=
 =?utf-8?B?bE0vcUpSZGhYZHl1ZWdTbTAySy9sYTZQNE1NbkNTVE1iTGVyZVdHODBXLzgy?=
 =?utf-8?B?ZXNRSWs1cjJ1ZnZsWkJqOUk3RkowOGVobEdRaVdFc1ExemJpeHlhZUNXMEw2?=
 =?utf-8?B?OHRyQjJIOFp4MC9Bem45WjRtTzVzYzRCZ083bm1PL2JMQ0orOTZEa0hId2NN?=
 =?utf-8?B?d1BvN3JvdlhOMjRyQThhQS9pYmIrdzFIaThHNWdDM3prWXlIUjEraStHVEov?=
 =?utf-8?B?L0JucDRPZW9hMGtpTk1lcTdsYWtNTEorWENBb0VYWXNiNXZyamNWd24vRm5s?=
 =?utf-8?B?cFN5K0ZIeTFMeUM1SllWTlY4WWhXK2o3aThPMjg1MDhHT1hUdk1aYlUxWEVS?=
 =?utf-8?B?bjhseW00MHAxa0lGZTEyZWZ6RmszQk5RYmw3MXFJdHJmZkhUSEtEL1JTU0dz?=
 =?utf-8?B?S0JNL0lwMUVDeFFXQmxVOXV3NTlOQXR4STQzUXRlaDljc0daQXJ0dGlzekha?=
 =?utf-8?B?WU1kUGI0ZEJLWU1JRjdwSHVnRUtsTWpRSG5JMGpiQkt6eGMvUERpWWx5d0l4?=
 =?utf-8?B?UGFNaTYwODV1S2hkbjVnc0xaOGxaSC9ENWdPdDhLdGZ4RktmNE5NelIxWEpE?=
 =?utf-8?B?M0h3aENvc0tYU29PR09BblpCZ0svZ2lQOUU3aTJCR1o4eFQreFdNUklhNW5S?=
 =?utf-8?B?M2RocmxDTDliMnBObXJULzRoMm9yemdEaFk4UVBESjVUbmt3cmJtUDg0Rkta?=
 =?utf-8?B?UTdnaE9YaGt3ajVSbmRuU2RZYTNmMjRNM25iWDkwanBFVzF6eFZ0RjhWbU1N?=
 =?utf-8?B?RnRrTVhRM2UvOENPTU55MWJ3WjBZei9CdnBqWHBtUmNjNHBzeFdNdXkwMkc1?=
 =?utf-8?B?Q0E0bElhQm5XRXU1UnIzVlltenhRZkNRRmE2eXduVnV1TWZQakROOVVocmpp?=
 =?utf-8?B?V1AxNksvekRBSEpDTUZLZnhHazlRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af6175-bf7a-411a-6686-08d9be862586
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:16:01.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEw7YT4aOJ6zorE3CoIN9SquFZ3zjhwsb/J1fhO17zc4xqdSPobOXT6PEsuVr5YVJCJil3mNl9tqBCwodRzcOnRp2yYKqffQYBRqaJOU95o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3730
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130130
X-Proofpoint-ORIG-GUID: fkBMc5hq7dbp8ZAiNM7_bXTYMPUwUF9q
X-Proofpoint-GUID: fkBMc5hq7dbp8ZAiNM7_bXTYMPUwUF9q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2021 4:37 PM, Damien Le Moal wrote:
> On 2021/12/14 0:33, George Kennedy wrote:
>> Avoid data corruption by rejecting pass-through commands where
>> T_LENGTH is zero (No data is transferred) and the dma direction
>> is not DMA_NONE.
>>
>> Cc:<stable@vger.kernel.org>  # 5.4.y
> 5.4 only ? What about other LTS versions ? They do not have that bug ?
Our distros are based on 5.4.y, 5.15.y and 4.14.y, so the fix should go 
there,
but it looks like the fix is also needed in: 5.14.y, 5.13.y, 5.10.y, and 
4.19.y.

Thank you,
George
>
>> Reported-by: syzkaller<syzkaller@googlegroups.com>
>> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
>> ---
>>    drivers/ata/libata-scsi.c | 6 ++++++
>>    1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 1b84d55..d428392 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>>    		goto invalid_fld;
>>    	}
>>    
>> +	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
>> +	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
>> +		fp = 2 + cdb_offset;
>> +		goto invalid_fld;
>> +	}
>> +
>>    	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
>>    		tf->protocol = ATA_PROT_NCQ_NODATA;
>>    
>> -- 1.8.3.1
>>
>

